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

/**
 Represents a waypoint, point of interest, or named feature on a map.
 */
public final class GKPoint {
    /// The coordinate of the point.
    public var coordinate: CLLocationCoordinate2D?

    /// Elevation (in meters) of the point.
    public var elevation: Float?

    /// Creation/modification timestamp for element. Date and time in are in Univeral Coordinated Time (UTC), not local time.
    public var time: NSDate?

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
    public var link: GKLink?

    /// Text of GPS symbol name. For interchange with other programs, use the exact spelling of the symbol as displayed on the GPS. If the GPS abbreviates words, spell them out.
    public var symbol: String?

    /// Type (classification) of the waypoint.
    public var type: String?

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
}

extension GKPoint: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored {
            return nil
        }
        
        // Check if coordinate is avaiable.
        guard let latitude = element.attributes["lat"], let longitude = element.attributes["lon"] else {
            return nil
        }
        self.init()
        
        coordinate                    <~ (Double(latitude)!, Double(longitude)!)
        elevation                     <~ element["ele"]
        meanSeaLevelHeight            <~ element["geoidheight"]
        name                          <~ element["name"]
        comment                       <~ element["cmt"]
        description                   <~ element["desc"]
        source                        <~ element["src"]
        symbol                        <~ element["sym"]
        type                          <~ element["type"]
        satelites                     <~ element["sat"]
        horizontalDilutionOfPrecision <~ element["hdop"]
        verticalDilutionOfPrecision   <~ element["vdop"]
        positionDilutionOfPrecision   <~ element["pdop"]
        ageOfTheGpxData               <~ element["ageofdgpsdata"]
        time                          <~ element["time"]
        link                          <~ element["link"]
    }
    
}