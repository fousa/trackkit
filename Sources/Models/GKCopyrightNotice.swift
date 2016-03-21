//
//  GKCopyrightNotice.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML

/**
 Information about the copyright holder and any license governing use of this file. By linking to an appropriate license, you may place your data into the public domain or grant additional usage rights.
*/
public final class GKCopyrightNotice {
    /// Copyright holder.
    public var author: String?

    /// Year of copyright.
    public var year: Int?
    
    /// Link to external file containing license text.
    public var license: String?
}

extension GKCopyrightNotice: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored {
            return nil
        }
        self.init()
        
        author = element.attributes["author"]
        
        year    <~ element["year"]
        license <~ element["license"]
    }
    
}