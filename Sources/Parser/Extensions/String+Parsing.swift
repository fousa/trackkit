//
//  String+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

extension String {
    
    init?(fromEmailElement element: AEXMLElement) {
        guard let id = element.attributes["id"], let domain = element.attributes["domain"] else {
            return nil
        }
        
        self = "\(id)@\(domain)"
    }
    
}
