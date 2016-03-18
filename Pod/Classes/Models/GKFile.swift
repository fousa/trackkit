//
//  GKFile.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import AEXML

public class GKFile {
    public var creator: String?
    public var name: String?
    public var description: String?
    public var copyrightNotice: GKCopyrightNotice?
    
    public var time: NSDate?
    
    public var author: GKPerson?
    public var link: GKLink?
    
    public var keywords: [String]?
    public var bounds: GKBounds?
    public var waypoints: [GKPoint]?
    public var routes: [GKRoute]?
    public var tracks: [GKTrack]?
}

extension GKFile {
    
    convenience init(fromElement element: AEXMLElement) {
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
