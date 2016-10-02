//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

func <~ <T: GPXable>(lhs: inout [T]?, rhs: [AEXMLElement]?) {
    if let elements = rhs?.flatMap({ T(gpx: $0) }), elements.count > 0 {
        lhs = elements
    }
}
