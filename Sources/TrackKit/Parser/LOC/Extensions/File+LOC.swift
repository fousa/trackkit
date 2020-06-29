//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension File {

    convenience init(loc rootElement: AEXMLElement) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .loc, version: rootElement.attributes["version"])
        self.init(type: .loc, version: version)

        // Fetch the creator from the root element.
        source = rootElement.attributes["src"]

        waypoints <~ rootElement["waypoint"].all?.compactMap { Point(loc: $0) }
    }

}
