//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

protocol GKMappable {
    init?(fromElement element: AEXMLElement)
}

infix operator <~ { associativity left }
func <~ <T: GKMappable>(inout lhs: T?, rhs: AEXMLElement) {
    lhs = T(fromElement: rhs)
}

func <~ <T: GKMappable>(inout lhs: [T]?, rhs: [AEXMLElement]?) {
    if let elements = rhs?.flatMap({ T(fromElement: $0) }) where elements.count > 0 {
        lhs = elements
    }
}

func <~ (inout lhs: String?, rhs: AEXMLElement) {
    lhs = rhs.optionalStringValue
}

func <~ (inout lhs: Int?, rhs: AEXMLElement) {
    lhs = rhs.optionalIntValue
}

func <~ (inout lhs: Float?, rhs: AEXMLElement) {
    lhs = rhs.optionalFloatValue
}

func <~ (inout lhs: CLLocationCoordinate2D?, rhs: (latitute: CLLocationDegrees, longitude: CLLocationDegrees)) {
    lhs = CLLocationCoordinate2DMake(rhs.latitute, rhs.longitude)
}

func <~ (inout lhs: [String]?, rhs: AEXMLElement) {
    lhs = rhs.optionalStringValue?.componentsSeparatedByString(",").map {
        $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

func <~ (inout lhs: NSDate?, rhs: AEXMLElement) {
    if let timeString = rhs.optionalStringValue {
        lhs = NSDate(fromString: timeString, format: .ISO8601(nil))
    }
}