//
//  GKLink+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

extension GKLink {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the link instance.
        if element.errored { return nil }
        
        mimeType = element["type"].optionalValue
        text = element["text"].optionalValue
        link = element.attributes["href"]
    }
    
}