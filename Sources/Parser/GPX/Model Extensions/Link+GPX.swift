//
//  File.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import AEXML

extension Link: GPXable {
    
    convenience init?(gpx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        self.init()
        
        link = element.attributes["href"]
        
        mimeType <~ element["type"]
        text     <~ element["text"]
    }
    
}
