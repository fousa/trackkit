//
//  GKFile+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

extension GKFile {
    
    mutating func map(fromDocument document: AEXMLDocument) {
        mapMetadata(fromDocument: document)
        mapWaypoints(fromDocument: document)
    }
    
    mutating func mapMetadata(fromDocument document: AEXMLDocument) {
        // Fetch the creator from the root element.
        creator = document.root.attributes["creator"]
        
        // Fetch the metadata from the metadata element.
        let metadata = document.root["metadata"]
        
        name            <~ metadata["name"]
        description     <~ metadata["desc"]
        author          <~ metadata["author"]
        copyrightNotice <~ metadata["copyright"]
        link            <~ metadata["link"]
        time            <~ metadata["time"]
        keywords        <~ metadata["keywords"]
        bounds          <~ metadata["bounds"]
    }
    
    mutating func mapWaypoints(fromDocument document: AEXMLDocument) {
        waypoints = document.root["wpt"].all?.flatMap { GKPoint(fromElement: $0) }
    }
    
}
