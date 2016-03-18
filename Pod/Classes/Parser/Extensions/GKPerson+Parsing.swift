//
//  GKPerson+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

extension GKPerson {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the link instance.
        if element.errored { return nil }
        
        name = element["name"].optionalValue
        email = ""
        email = String(fromEmailElement: element["email"])
        link = GKLink(fromElement: element["link"])
    }
    
}