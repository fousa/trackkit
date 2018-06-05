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
    public private(set) var distance: CLLocationDistance?
    /// The total height gained during the track.
    public private(set) var heighGained: CLLocationDistance?
    
    /// Initialize a track with a points.
    init(points: [ImprovedPoint]) {
        self.points = points
        var coordinates = points.compactMap { $0.coordinate }
        self.polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
    }
}

extension ImprovedRoute {
    /// Parse the file from a gpx document.
    convenience init?(gpx element: AEXMLElement) {
        guard element.error == nil else { return nil }
        
        var points: [ImprovedPoint] = []
        var distance: CLLocationDistance = 0.0
        var heighGained: CLLocationDistance = 0.0
        var previousPoint: ImprovedPoint?
        element["rte"].all?.forEach { track in
            track["rtept"].all?.forEach { routePoint in
                guard let point = ImprovedPoint(gpx: routePoint) else { return }
                let mapPoint = MKMapPointForCoordinate(point.coordinate)
                if let previousPoint = previousPoint {
                    let previousMapPoint = MKMapPointForCoordinate(previousPoint.coordinate)
                    distance +=  MKMetersBetweenMapPoints(previousMapPoint, mapPoint)
                    if
                        let previousElevation = previousPoint.elevation,
                        let elevation = point.elevation,
                        previousElevation < elevation {
                        heighGained += elevation - previousElevation
                    }
                }
                points.append(point)
                previousPoint = point
            }
        }
        guard points.count > 0 else { return nil }
        
        self.init(points: points)
        
        self.distance = distance
        self.heighGained = heighGained
    }
}
