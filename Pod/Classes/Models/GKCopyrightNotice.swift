//
//  GKCopyrightNotice.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML

public final class GKCopyrightNotice {
    public var author: String?
    public var year: Int?
    public var license: String?
}

extension GKCopyrightNotice: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        self.init()
        
        author = element.attributes["author"]
        
        year    <~ element["year"]
        license <~ element["license"]
    }
    
}