//
//  ImprovedRoute.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 04/06/2018.
//

import MapKit
import AEXML

public class ImprovedRoute {
    /// The location points.
    public private(set) var points: [ImprovedPoint]
    /// The track's polyline to display on the map.
    public private(set) var polyline: MKPolyline
    /// The total distance of the track.
    public private(set) var distance: CLLocationDistance
    /// The total height gained during the track.
    public private(set) var heighGained: CLLocationDistance?
    
    /// Initialize a track with a points.
    init(points: [ImprovedPoint], distance: CLLocationDistance) {
        self.points = points
        var coordinates = points.compactMap { $0.coordinate }
        self.polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        self.distance = distance
    }
}

extension ImprovedRoute {
    /// Parse the file from a gpx document.
    convenience init?(gpx element: AEXMLElement) {
        guard element.error == nil else { return nil }
        
        var points: [ImprovedPoint] = []
        var previousPoint: ImprovedPoint?
        var distance: CLLocationDistance = 0.0
        var heighGained: CLLocationDistance?
        
        /// Iterate all the points.
        element["rte"].all?.forEach { route in
            route["rtept"].all?.forEach { routePoint in
                guard let point = ImprovedPoint(gpx: routePoint) else { return }
                // When a previous Point is available we calculate some metadata.
                if let previousPoint = previousPoint {
                    distance +=  MKMetersBetweenMapPoints(previousPoint.mapPoint, point.mapPoint)
                    if
                        let previousElevation = previousPoint.elevation,
                        let elevation = point.elevation,
                        previousElevation < elevation {
                        heighGained = (heighGained ?? 0.0) + elevation - previousElevation
                    }
                }
                // Persist the point and save the previous one.
                points.append(point)
                previousPoint = point
            }
        }
        
        // When no points are found we return a nil point.
        guard points.count > 0 else { return nil }
        self.init(points: points, distance: distance)
        
        self.heighGained = heighGained
    }
}
