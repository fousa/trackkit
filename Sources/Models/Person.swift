//
//  GKPerson.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

/**
 A person or organization.
*/
public final class Person {
    /// Name of person or organization.
    public var name: String?
    
    /// Email address.
    public var email: String?

    /// Link to Web site or other external information about person.
    public var link: Link?
}

extension Person: Mappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        self.init()
        
        email = String(fromEmailElement: element["email"])
        
        name  <~ element["name"]
        link  <~ element["link"]
    }
    
}