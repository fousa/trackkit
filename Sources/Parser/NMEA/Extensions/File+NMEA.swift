//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

extension File {

    convenience init(nmea rawData: [[String]]) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .nmea, version: "NMEA-0183")
        self.init(type: .nmea, version: version)

        let points = rawData.compactMap { Point(nmea: $0) }
        let waypoints = points.filter { $0.recordType?.isWaypoint ?? false }
        let records = points.filter { !($0.recordType?.isWaypoint ?? false) }

        self.records = records.count > 0 ? records : nil
        self.waypoints = waypoints.count > 0 ? waypoints : nil
    }

}
