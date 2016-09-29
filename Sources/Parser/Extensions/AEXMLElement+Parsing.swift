//
//  AEXMLElement.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

extension AEXMLElement {

    var optionalString: String? {
        if let _ = error {
            return nil
        }
        return value
    }

    var optionalInt: Int? {
        if let _ = error {
            return nil
        }
        return int
    }

    var optionalFloat: Float? {
        if let _ = error {
            return nil
        }
        return Float(double)
    }

}
