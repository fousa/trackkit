//
//  ImprovedFile.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 02/06/2018.
//

import MapKit
import AEXML

public class ImprovedFile {
    /// The waypoints.
    public private(set) var waypoints: [ImprovedPoint]?
    /// The track.
    public private(set) var track: ImprovedTrack?
    /// The route.
    public private(set) var route: ImprovedRoute?
    /// The bounds of the file.
    public private(set) var boundingRect: MKMapRect?
}

extension ImprovedFile {
    /// Parse the file from a gpx document.
    convenience init(gpx data: Data) throws {
        // Parse the XML.
        let gpx: AEXMLDocument
        do {
            gpx = try AEXMLDocument(xml: data)
        } catch {
            throw ImprovedParserError.invalidFormat
        }
        // Validate the version.
        try ImprovedFileType.gpx.validate(version: gpx.root.attributes["version"])
        self.init()
        
        // Parse the waypoints.
        waypoints = gpx.root["wpt"].all?.compactMap { ImprovedPoint(gpx: $0) }
        // Parse the track.
        track = ImprovedTrack(gpx: gpx.root)
        // Parse the route.
        route = ImprovedRoute(gpx: gpx.root)
    }
}
