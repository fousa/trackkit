//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension File {

    convenience init(gpx rootElement: AEXMLElement) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .gpx, version: rootElement.attributes["version"])
        self.init(type: .gpx, version: version)

        // Fetch the creator from the root element.
        creator = rootElement.attributes["creator"]

        // Fetch the metadata from the metadata element.
        let metadata = rootElement["metadata"]

        name            <~ metadata["name"]
        description     <~ metadata["desc"]
        author          <~ Person(gpx: metadata["author"])
        copyrightNotice <~ CopyrightNotice(gpx: metadata["copyright"])
        link            <~ Link(gpx: metadata["link"])
        time            <~ metadata["time"]
        keywords        <~ metadata["keywords"]
        bounds          <~ Bounds(gpx: metadata["bounds"])
        waypoints       <~ rootElement["wpt"].all?.flatMap { Point(gpx: $0) }
        routes          <~ rootElement["rte"].all?.flatMap { Route(gpx: $0) }
        tracks          <~ rootElement["trk"].all?.flatMap { Track(gpx: $0) }
    }

}
