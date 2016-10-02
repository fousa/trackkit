//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

protocol TCXableElement {}

func <~ <T: TCXable, U: TCXableElement>(lhs: inout T?, rhs: U) where U: AEXMLElement {
    lhs = T(tcx: rhs)
}

func <~ <T: TCXable>(lhs: inout [T]?, rhs: [AEXMLElement]?) {
    if let elements = rhs?.flatMap({ T(tcx: $0) }), elements.count > 0 {
        lhs = elements
    }
}
