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
open class File {
    /// You must include the name or URL of the software that created your GPX document. This allows others to inform the creator of a GPX instance document that fails to validate.
    open var creator: String?

    /// The name of the GPX file.
    open var name: String?

    /// A description of the contents of the GPX file.
    open var description: String?

    /// The person or organization who created the GPX file.
    open var author: Person?

    /// Copyright and license information governing use of the file.
    open var copyrightNotice: CopyrightNotice?

    /// URLs associated with the location described in the file.
    open var link: Link?

    /// The creation date of the file.
    open var time: Date?

    /// Keywords associated with the file. Search engines or databases can use this information to classify the data.
    open var keywords: [String]?

    /// Minimum and maximum coordinates which describe the extent of the coordinates in the file.
    open var bounds: Bounds?

    /// A list of waypoints.
    open var waypoints: [Point]?

    /// A list of routes.
    open var routes: [Route]?

    /// A list of tracks.
    open var tracks: [Track]?
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
