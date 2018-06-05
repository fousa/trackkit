//
//  ImprovedTrack.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 02/06/2018.
//

import MapKit
import AEXML

public class ImprovedTrack {
    /// The location points.
    public private(set) var points: [ImprovedPoint]
    /// The track's polyline to display on the map.
    public private(set) var polyline: MKPolyline
    /// The total distance of the track.
    public private(set) var distance: CLLocationDistance
    /// The total height gained during the track.
    public private(set) var heighGained: CLLocationDistance?
    /// The total duration of the track.
    public private(set) var duration: TimeInterval?
    /// The average speed during the track.
    public private(set) var averageSpeed: CLLocationSpeed?
    /// The maximum speed of the track.
    public private(set) var maximumSpeed: CLLocationSpeed?
    /// The average heart rate during the track.
    public private(set) var averageHeartRate: Int?
    /// The maximum heart rate of the track.
    public private(set) var maximumHeartRate: Int?
    /// The average cadence during the track.
    public private(set) var averageCadence: Int?
    /// The average temperature during the track.
    public private(set) var averageTemperature: Int?
    
    /// Initialize a track with a points.
    init(points: [ImprovedPoint], distance: CLLocationDistance) {
        self.points = points
        var coordinates = points.compactMap { $0.coordinate }
        self.polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        self.distance = distance
    }
}

extension ImprovedTrack {
    /// Parse the file from a gpx document.
    convenience init?(gpx element: AEXMLElement) {
        guard element.error == nil else { return nil }
        
        var points: [ImprovedPoint] = []
        var distance: CLLocationDistance = 0.0
        var heighGained: CLLocationDistance?
        var previousPoint: ImprovedPoint?
        var maximumSpeed: CLLocationSpeed = 0.0
        var maximumHeartRate: Int = 0
        var totalHeartRate: Int = 0
        var totalCadence: Int = 0
        var totalTemperature: Int?
        
        /// Iterate all the points.
        element["trk"].all?.forEach { track in
            track["trkseg"].all?.forEach { segment in
                segment["trkpt"].all?.forEach { segmentPoint in
                    guard let point = ImprovedPoint(gpx: segmentPoint) else { return }
                    // When a previous Point is available we calculate some metadata.
                    if let previousPoint = previousPoint {
                        let pointDistance = MKMetersBetweenMapPoints(previousPoint.mapPoint, point.mapPoint)
                        distance += pointDistance
                        if
                            let previousElevation = previousPoint.elevation,
                            let elevation = point.elevation {
                            point.grade = Int((elevation - previousElevation) / pointDistance * 100.0)
                            if previousElevation < elevation {
                                heighGained = (heighGained ?? 0.0) + elevation - previousElevation
                            }
                        }
                        
                        if
                            let currentTime = point.timestamp,
                            let previousTime = previousPoint.timestamp {
                            let duration = currentTime.timeIntervalSince1970 - previousTime.timeIntervalSince1970
                            point.speed = pointDistance / duration
                        }
                    }
                    if let heartRate = point.heartRate {
                        if heartRate > maximumHeartRate {
                            maximumHeartRate = heartRate
                        }
                        totalHeartRate += heartRate
                    }
                    if let cadence = point.cadence {
                        totalCadence += cadence
                    }
                    if let temperature = point.temperature {
                        totalTemperature = (totalTemperature ?? 0) + temperature
                    }
                    if
                        let speed = point.speed,
                        speed > maximumSpeed {
                        maximumSpeed = speed
                    }
                    points.append(point)
                    previousPoint = point
                }
            }
        }
        guard points.count > 0 else { return nil }

        self.init(points: points, distance: distance)
        
        self.maximumHeartRate = maximumHeartRate
        self.maximumSpeed = maximumSpeed
        self.heighGained = heighGained
        if
            let startTime = points.first?.timestamp,
            let endTime = points.last?.timestamp {
            duration = endTime.timeIntervalSince1970 - startTime.timeIntervalSince1970
            averageSpeed = distance / duration!
        }
        averageHeartRate = totalHeartRate / points.count
        averageCadence = totalCadence / points.count
        if let totalTemperature = totalTemperature {
            averageTemperature = totalTemperature / points.count
        }
    }
}
