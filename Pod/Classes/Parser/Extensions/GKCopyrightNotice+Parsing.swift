//
//  GKCopyrightNotice+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

extension GKCopyrightNotice {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the copyright instance.
        if element.errored { return nil }
        
        year = element["year"].optionalIntValue
        license = element["license"].optionalValue
        author = element.attributes["author"]
    }
    
}