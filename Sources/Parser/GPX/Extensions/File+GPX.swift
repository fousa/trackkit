//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension File {

    convenience init(gpx rootElement: AEXMLElement) throws {
        // When the element is an error, don't create the instance.
        if rootElement.attributes["version"] != "1.1" {
            throw TrackParseError.invalidVersion
        }
        self.init(type: .gpx)

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
