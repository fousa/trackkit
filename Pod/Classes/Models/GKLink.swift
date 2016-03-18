//
//  GKLink.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import AEXML

public final class GKLink {
    public var link: String? = nil
    public var text: String? = nil
    public var mimeType: String? = nil
}

extension GKLink: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        self.init()
        
        link = element.attributes["href"]
        
        mimeType <~ element["type"]
        text     <~ element["text"]
    }
    
}