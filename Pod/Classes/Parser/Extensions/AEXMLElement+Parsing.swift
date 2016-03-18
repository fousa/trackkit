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
    
    var optionalStringValue: String? {
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
    
    var optionalFloatValue: Float? {
        if errored {
            return nil
        }
        return Float(doubleValue)
    }
    
    var errored: Bool {
        return name == AEXMLElement.errorElementName
    }
    
}