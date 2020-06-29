//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension File {

    // MARK: - Init

    convenience init(gpx rootElement: AEXMLElement) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .gpx, version: rootElement.attributes["version"])
        self.init(type: .gpx, version: version)

        // Fetch the creator from the root element.
        creator = rootElement.attributes["creator"]

        var metadata = rootElement
        if version.versionString == "1.1" {
            // Fetch the metadata from the metadata element.
            metadata = rootElement["metadata"]
        }

        // Fetch the metadata from the metadata element.
        parseMetadata(from: metadata)

        waypoints       <~ rootElement["wpt"].all?.compactMap { Point(gpx: $0, version: typeVersion) }
        routes          <~ rootElement["rte"].all?.compactMap { Route(gpx: $0, version: typeVersion) }
        tracks          <~ rootElement["trk"].all?.compactMap { Track(gpx: $0, version: typeVersion) }
    }

    // MARK: - Parsing

    private func parseMetadata(from element: AEXMLElement) {
        name            <~ element["name"]
        description     <~ element["desc"]
        author          <~ Person(gpx: element, version: typeVersion)
        link            <~ Link(gpx: element, version: typeVersion)
        copyrightNotice <~ CopyrightNotice(gpx: element["copyright"], version: typeVersion)
        time            <~ element["time"]
        keywords        <~ element["keywords"]
        bounds          <~ Bounds(gpx: element["bounds"], version: typeVersion)
    }

}
