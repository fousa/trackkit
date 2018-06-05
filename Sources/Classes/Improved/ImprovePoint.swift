//
//  ImprovedPoint.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 02/06/2018.
//

import CoreLocation
import MapKit
import AEXML

public class ImprovedPoint {
    /// The point's coordinate
    public private(set) var coordinate: CLLocationCoordinate2D
    /// The timestamp of the logging.
    public private(set) var timestamp: Date?
    /// The speed at the current point.
    public var speed: CLLocationSpeed?
    /// The point's elevation.
    public private(set) var elevation: CLLocationDistance?
    /// The elevation grade at the current point.
    public var grade: Int?
    /// The heart rate at the current point.
    public private(set) var heartRate: Int?
    /// The cadence when cycling at the current point.
    public private(set) var cadence: Int?
    /// The temperature at the current point.
    public private(set) var temperature: Int?
    /// The name of a waypoint.
    public private(set) var name: String?
    /// The description of a waypoint.
    public private(set) var description: String?
    
    /// Initialize a point with a coordinate.
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    /// Return the map point.
    lazy var mapPoint: MKMapPoint = { [unowned self] in
        return MKMapPointForCoordinate(coordinate)
    }()
}

extension ImprovedPoint {
    convenience init?(gpx element: AEXMLElement) {
        guard
            element.error == nil,
            let latitude = element.attributes["lat"],
            let latitudeValue = Double(latitude),
            let longitude = element.attributes["lon"],
            let longitudeValue = Double(longitude) else { return nil }

        self.init(coordinate: CLLocationCoordinate2DMake(latitudeValue, longitudeValue))
        
        elevation   <~ element["ele"]
        timestamp   <~ element["time"]
        name        <~ element["name"]
        description <~ element["desc"]
        
        let extensionsElement = element["extensions"]["gpxtpx:TrackPointExtension"]
        temperature <~ extensionsElement["gpxtpx:atemp"]
        heartRate   <~ extensionsElement["gpxtpx:hr"]
        cadence     <~ extensionsElement["gpxtpx:cad"]
    }
}
