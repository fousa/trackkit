//
//  GKFile.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import AEXML

/**
 The root element in the XML file.
 */
public class File {
    /// You must include the name or URL of the software that created your GPX document. This allows others to inform the creator of a GPX instance document that fails to validate.
    public var creator: String?

    /// The name of the GPX file.
    public var name: String?

    /// A description of the contents of the GPX file.
    public var description: String?

    /// The person or organization who created the GPX file.
    public var author: Person?

    /// Copyright and license information governing use of the file.
    public var copyrightNotice: CopyrightNotice?

    /// URLs associated with the location described in the file.
    public var link: Link?

    /// The creation date of the file.
    public var time: NSDate?

    /// Keywords associated with the file. Search engines or databases can use this information to classify the data.
    public var keywords: [String]?

    /// Minimum and maximum coordinates which describe the extent of the coordinates in the file.
    public var bounds: Bounds?

    /// A list of waypoints.
    public var waypoints: [Point]?

    /// A list of routes.
    public var routes: [Route]?

    /// A list of tracks.
    public var tracks: [Track]?
}

extension File {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.attributes["version"] != "1.1" {
            return nil
        }
        self.init()
        
        // Fetch the creator from the root element.
        creator = element.attributes["creator"]
        
        // Fetch the metadata from the metadata element.
        let metadata = element["metadata"]
        
        name            <~ metadata["name"]
        description     <~ metadata["desc"]
        author          <~ metadata["author"]
        copyrightNotice <~ metadata["copyright"]
        link            <~ metadata["link"]
        time            <~ metadata["time"]
        keywords        <~ metadata["keywords"]
        bounds          <~ metadata["bounds"]
        waypoints       <~ element["wpt"].all
        routes          <~ element["rte"].all
        tracks          <~ element["trk"].all
    }
    
}
