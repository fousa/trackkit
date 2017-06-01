//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension File {

    convenience init(nmea rawData: [[String]]) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .nmea, version: "NMEA-0183")
        self.init(type: .nmea, version: version)
    }

}
