//
//  GKPoint.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

/// Type of GPS fix. none means GPS had no fix. To signify "the fix info is unknown, leave out fixType entirely. pps = military signal used.
public enum FixType: String {
    /// GPS had no fix.
    case none = "none"
    
    /// 2 dimentional fix.
    case twoD = "2d"
    
    /// 3 dimentional fix.
    case threeD = "3d"
    
    /// Differential Global Positioning System.
    case dgps = "dgps"
    
    /// Military signal used
    case pps = "pps"
}

/**
 Represents a waypoint, point of interest, or named feature on a map.
 */
public final class Point {
    /// The coordinate of the point.
    public var coordinate: CLLocationCoordinate2D?

    /// Elevation (in meters) of the point.
    public var elevation: Float?

    /// Creation/modification timestamp for element. Date and time in are in Univeral Coordinated Time (UTC), not local time.
    public var time: NSDate?
    
    /// Magnetic variation.
    public var magneticVariation: Float?

    /// Height (in meters) of geoid (mean sea level) above WGS84 earth ellipsoid. As defined in NMEA GGA message.
    public var meanSeaLevelHeight: Float?

    /// The GPS name of the waypoint. This field will be transferred to and from the GPS. GPX does not place restrictions on the length of this field or the characters contained in it. It is up to the receiving application to validate the field before sending it to the GPS.
    public var name: String?

    /// GPS waypoint comment. Sent to GPS as comment.
    public var comment: String?

    /// A text description of the element. Holds additional information about the element intended for the user, not the GPS.
    public var description: String?

    /// Source of data. Included to give user some idea of reliability and accuracy of data. "Garmin eTrex", "USGS quad Boston North", e.g.
    public var source: String?

    /// Link to additional information about the waypoint.
    public var link: Link?

    /// Text of GPS symbol name. For interchange with other programs, use the exact spelling of the symbol as displayed on the GPS. If the GPS abbreviates words, spell them out.
    public var symbol: String?

    /// Type (classification) of the waypoint.
    public var type: String?
    
    /// Type of GPS fix.
    public var fix: FixType?

    /// Number of satellites used to calculate the GPX fix.
    public var satelites: Int?

    /// Horizontal dilution of precision.
    public var horizontalDilutionOfPrecision: Float?

    /// Vertical dilution of precision.
    public var verticalDilutionOfPrecision: Float?

    /// Position dilution of precision.
    public var positionDilutionOfPrecision: Float?

    /// Number of seconds since last DGPS update.
    public var ageOfTheGpxData: Float?
    
    /// Represents a differential GPS station.
    public var dgpsStationType: Int?
}

extension Point: Mappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        
        // Check if coordinate is avaiable.
        guard let latitude = element.attributes["lat"], let longitude = element.attributes["lon"] else {
            return nil
        }
        self.init()
        
        coordinate                    <~ (Double(latitude)!, Double(longitude)!)
        elevation                     <~ element["ele"]
        magneticVariation             <~ element["magvar"]
        meanSeaLevelHeight            <~ element["geoidheight"]
        name                          <~ element["name"]
        comment                       <~ element["cmt"]
        description                   <~ element["desc"]
        source                        <~ element["src"]
        symbol                        <~ element["sym"]
        type                          <~ element["type"]
        fix                           <~ element["fix"]
        satelites                     <~ element["sat"]
        horizontalDilutionOfPrecision <~ element["hdop"]
        verticalDilutionOfPrecision   <~ element["vdop"]
        positionDilutionOfPrecision   <~ element["pdop"]
        ageOfTheGpxData               <~ element["ageofdgpsdata"]
        dgpsStationType               <~ element["dgpsid"]
        time                          <~ element["time"]
        link                          <~ element["link"]
    }
    
}