//
//  GKPerson.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

public final class GKPerson {
    public var name: String?
    public var email: String?
    
    public var link: GKLink?
}

extension GKPerson: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        self.init()
        
        email = String(fromEmailElement: element["email"])
        
        name  <~ element["name"]
        link  <~ element["link"]
    }
    
}