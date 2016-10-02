//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

func <~ <T: TCXable>(lhs: inout [T]?, rhs: [AEXMLElement]?) {
    if let elements = rhs?.flatMap({ T(tcx: $0) }), elements.count > 0 {
        lhs = elements
    }
}
