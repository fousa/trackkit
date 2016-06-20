//
//  GKLink.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import AEXML

/**
 A link to an external resource (Web page, digital photo, video clip, etc) with additional information.
*/
public final class Link {
    /// URL of hyperlink.
    public var link: String?

    /// Text of hyperlink.
    public var text: String?
    
    /// Mime type of content.
    public var mimeType: String?
}

extension Link: Mappable {
    
    convenience init?(fromElement element: AEXMLElement) {
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