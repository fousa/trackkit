//
//  AEXMLElement.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML

extension AEXMLElement {
    
    var optionalValue: String? {
        if errored {
            return nil
        }
        return value
    }
    
    var optionalIntValue: Int? {
        if errored {
            return nil
        }
        return intValue
    }
    
    var errored: Bool {
        return name == AEXMLElement.errorElementName
    }
    
}