//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import CoreLocation

/// Type of GPS fix. none means GPS had no fix. To signify "the fix info is unknown,
/// leave out fixType entirely. pps = military signal used.
///
/// - important: Supported format: GPX
public enum Fix: String {
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

/// Navigation receiver warning.
///
/// - important: Supported format: NMEA
public enum NavigationReceiverWarning: String {
    /// Ok
    // swiftlint:disable identifier_name
    case ok = "A"

    /// Warning
    case warning = "V"
}

/// Type of GPS Quality indicator.
///
/// - important: Supported format: NMEA
public enum GPSQuality: String {
    /// Fix not valid.
    case invalid = "0"

    /// GPX Fix
    case gpsFix = "1"

    /// Differential GPS fix, OmniSTAR VBS
    case differentialGPSFix = "2"

    /// Real-Time Kinematic, fixed integers
    case realTimeKinematicFixed = "4"

    /// Real-Time Kinematic, float integers, OmniSTAR XP/HP or Location RTK
    case realTimeKinematicFloat = "5"
}

/// NMEA Record type, only the types below are supported.
///
/// - important: Supported format: NMEA
public enum RecordType: String {
    /// Global Positioning System Fix Data
    case gga = "$GPGGA"

    /// Recommended minimum specific GPS/Transit data
    case rmc = "$GPRMC"

    /// Geographic Position, Latitude / Longitude and time
    case gll = "$GPGLL"

    /// Waypoint location
    case wpl = "$GPWPL"
}

/// Represents a waypoint, point of interest, or named feature on a map.
///
/// - important: Supported format: GPX, TCX, NMEA
public final class Point: Codable {
    /// The coordinate of the point.
    ///
    /// - important: Supported format: GPX, TCX, LOC
    public var coordinate: CLLocationCoordinate2D?

    /// Elevation (in meters) of the point.
    ///
    /// - important: Supported format: GPX, TCX, NMEA
    public var elevation: Double?

    /// Distance (in meters) of the point.
    ///
    /// - important: Supported format: GPX, TCX
    public var distance: Double?

    /// Creation/modification timestamp for element. Date and time in are in Univeral
    /// Coordinated Time (UTC), not local time.
    ///
    /// - important: Supported format: GPX, TCX, NMEA
    public var time: Date?

    /// Magnetic variation.
    ///
    /// - important: Supported format: GPX
    public var magneticVariation: Double?

    /// Height (in meters) of geoid (mean sea level) above WGS84 earth ellipsoid. As
    /// defined in NMEA GGA message.
    ///
    /// - important: Supported format: GPX
    public var meanSeaLevelHeight: Double?

    /// The GPS name of the waypoint. This field will be transferred to and from the
    /// GPS. GPX does not place restrictions on the length of this field or the characters
    /// contained in it. It is up to the receiving application to validate the field before
    /// sending it to the GPS.
    ///
    /// - important: Supported format: GPX, LOC, NMEA
    public var name: String?

    /// GPS waypoint comment. Sent to GPS as comment.
    ///
    /// - important: Supported format: GPX
    public var comment: String?

    /// A text description of the element. Holds additional information about the element
    /// intended for the user, not the GPS.
    ///
    /// - important: Supported format: GPX, LOC
    public var description: String?

    /// Source of data. Included to give user some idea of reliability and accuracy of data.
    /// "Garmin eTrex", "USGS quad Boston North", e.g.
    ///
    /// - important: Supported format: GPX
    public var source: String?

    /// Link to additional information about the waypoint.
    ///
    /// - important: Supported format: GPX, LOC
    public var link: Link?

    /// Text of GPS symbol name. For interchange with other programs, use the exact spelling
    /// of the symbol as displayed on the GPS. If the GPS abbreviates words, spell them out.
    ///
    /// - important: Supported format: GPX
    public var symbol: String?

    /// Type (classification) of the waypoint.
    ///
    /// - important: Supported format: GPX, LOC
    public var type: String?

    /// Type of GPS fix.
    ///
    /// - important: Supported format: GPX
    public var fix: Fix?

    /// Number of satellites used to calculate the GPX fix.
    ///
    /// - important: Supported format: GPX
    public var satelites: Int?

    /// Horizontal dilution of precision.
    ///
    /// - important: Supported format: GPX
    public var horizontalDilutionOfPrecision: Double?

    /// Vertical dilution of precision.
    ///
    /// - important: Supported format: GPX
    public var verticalDilutionOfPrecision: Double?

    /// Position dilution of precision.
    ///
    /// - important: Supported format: GPX
    public var positionDilutionOfPrecision: Double?

    /// Number of seconds since last DGPS update.
    ///
    /// - important: Supported format: GPX
    public var ageOfTheGpxData: Double?

    /// Represents a differential GPS station.
    ///
    /// - important: Supported format: GPX
    public var dgpsStationType: Int?

    /// Number of satelittes in use.
    ///
    /// - important: Supported format: NMEA
    public var numberOfSatellites: Int?

    /// Height of geoid above WGS84 ellipsoid (in meters).
    ///
    /// - important: Supported format: NMEA
    public var heightOfGeoid: Double?

    /// Age of differential GPS data record.
    ///
    /// - important: Supported format: NMEA
    public var timeSinceLastUpdate: Double?

    /// Reference station ID.
    ///
    /// - important: Supported format: NMEA
    public var stationId: String?

    /// GPS Quality indicator.
    ///
    /// - important: Supported format: NMEA
    public var gpsQuality: GPSQuality?

    /// The NMEA record type.
    ///
    /// - important: Supported format: NMEA
    public var recordType: RecordType?

    /// The navigation receiver warning.
    ///
    /// - important: Supported format: NMEA
    public var navigationReceiverWarning: NavigationReceiverWarning?

    /// Track angle in degrees.
    ///
    /// - important: Supported format: NMEA
    public var trackAngle: Double?

    /// Heartrate at this point.
    ///
    /// - important: Supported format: TCX, GPX
    public var heartRate: Int?

    /// Cadence at this point.
    ///
    /// - important: Supported format: TCX, GPX
    public var cadence: Int?

    /// Air temperature at this point.
    ///
    /// - important: Supported format: GPX
    public var airTemperature: Double?

    /// Water temperature at this point.
    ///
    /// - important: Supported format: GPX
    public var waterTemperature: Double?

    /// Depth at this point.
    ///
    /// - important: Supported format: GPX
    public var depth: Double?

    /// Speed at this point.
    ///
    /// - important: Supported format: GPX, NMEA, TRACK
    public var speed: Double?

    /// Course at this point.
    ///
    /// - important: Supported format: GPX, TRACK
    public var course: CLLocationDirection?

    /// Bearing at this point.
    ///
    /// - important: Supported format: GPX
    public var bearing: Int?
    
    /// Horizontal accuracy.
    ///
    /// - important: Supported format: TRACK
    public var horizontalAccuracy: Double?
    
    /// Vertical accuracy.
    ///
    /// - important: Supported format: TRACK
    public var verticalAccuracy: Double?
    
    public init() {
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        elevation = try? container.decode(CLLocationDistance.self, forKey: .altitude)
        horizontalAccuracy = try? container.decode(CLLocationAccuracy.self, forKey: .horizontalAccuracy)
        verticalAccuracy = try? container.decode(CLLocationAccuracy.self, forKey: .verticalAccuracy)
        course = try? container.decode(CLLocationDirection.self, forKey: .course)
        speed = try? container.decode(CLLocationSpeed.self, forKey: .speed)
        time = try? container.decode(Date.self, forKey: .timestamp)
    }
}
