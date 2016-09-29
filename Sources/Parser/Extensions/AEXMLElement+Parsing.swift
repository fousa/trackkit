//
//  AEXMLElement.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

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
        return int
    }

    var optionalFloatValue: Float? {
        if let _ = error {
            return nil
        }
        return Float(double)
    }

}
