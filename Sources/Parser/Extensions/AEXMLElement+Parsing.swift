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
        if let _ = error {
            return nil
        }
        return value
    }
    
    var optionalIntValue: Int? {
        if let _ = error {
            return nil
        }
        return intValue
    }
    
    var optionalFloatValue: Float? {
        if let _ = error {
            return nil
        }
        return Float(doubleValue)
    }
    
}