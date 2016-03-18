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
    
    mutating func appendMetadata(fromDocument document: AEXMLDocument) {
        // Fetch the creator from the root element.
        creator = document.root.attributes["creator"]
        
        // Fetch the metadata from the metadata element.
        let metadata = document.root["metadata"]
        name = metadata["name"].optionalValue
        description = metadata["desc"].optionalValue
        
        // Parse the author.
        author = GKPerson(fromElement: metadata["author"])
        
        // Parse the metadata copyright notice.
        copyrightNotice = GKCopyrightNotice(fromElement: metadata["copyright"])
        
        // Parse the metadata link.
        link = GKLink(fromElement: metadata["link"])
        
        // Parse the time.
        if let timeString = metadata["time"].optionalValue {
            time = NSDate(fromString: timeString, format: .ISO8601(nil))
        }
        
        // Parse the keywords.
        if let keywordsString = metadata["keywords"].optionalValue {
            keywords = keywordsString.componentsSeparatedByString(",").map {
                $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            }
        }
        
        // Parse the metadata bounds.
        bounds = GKBounds(fromElement: metadata["bounds"])
    }
    
    mutating func appendWaypoints(fromDocument document: AEXMLDocument) {
        guard let elements = document.root["wpt"].all else {
            return
        }
        
        waypoints = [GKPoint]()
        for _ in elements {
            waypoints?.append(GKPoint())
        }
    }
    
}
