//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import AEXML    

infix operator <~ { associativity left }
func <~ (inout lhs: GKLink?, rhs: AEXMLElement) {
    lhs = GKLink(fromElement: rhs)
}

func <~ (inout lhs: GKCopyrightNotice?, rhs: AEXMLElement) {
    lhs = GKCopyrightNotice(fromElement: rhs)
}

func <~ (inout lhs: GKPerson?, rhs: AEXMLElement) {
    lhs = GKPerson(fromElement: rhs)
}

func <~ (inout lhs: GKBounds?, rhs: AEXMLElement) {
    lhs = GKBounds(fromElement: rhs)
}

func <~ (inout lhs: String?, rhs: AEXMLElement) {
    lhs = rhs.optionalValue
}

func <~ (inout lhs: [String]?, rhs: AEXMLElement) {
    lhs = rhs.optionalValue?.componentsSeparatedByString(",").map {
        $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

func <~ (inout lhs: NSDate?, rhs: AEXMLElement) {
    if let timeString = rhs.optionalValue {
        lhs = NSDate(fromString: timeString, format: .ISO8601(nil))
    }
}