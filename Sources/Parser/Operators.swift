//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import CoreLocation
import AEXML

protocol Parsable {}

precedencegroup OperatorPresedenceGroup {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator <~: OperatorPresedenceGroup

func <~ (lhs: inout String?, rhs: AEXMLElement) {
    lhs = rhs.optionalString
}

func <~ (lhs: inout Int?, rhs: AEXMLElement) {
    lhs = rhs.optionalInt
}

func <~ (lhs: inout Double?, rhs: AEXMLElement) {
    lhs = rhs.optionalDouble
}

func <~ (lhs: inout CLLocationCoordinate2D?,
         rhs: (latitute: CLLocationDegrees, longitude: CLLocationDegrees)) {
    lhs = CLLocationCoordinate2DMake(rhs.latitute, rhs.longitude)
}

func <~ (lhs: inout [String]?, rhs: AEXMLElement) {
    lhs = rhs.optionalString?.components(separatedBy: ",").map {
        $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

func <~ (lhs: inout Date?, rhs: AEXMLElement) {
    lhs = rhs.optionalString?.isoDate() as Date?
}

func <~ (lhs: inout URL?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = URL(string: stringValue)
    }
}

func <~ (lhs: inout FixType?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = FixType(rawValue: stringValue)
    }
}

func <~ (lhs: inout IntentityType?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = IntentityType(rawValue: stringValue)
    }
}

func <~ <T: Parsable>(lhs: inout T?, rhs: T?) {
    lhs = rhs
}

func <~ <T: Parsable>(lhs: inout [T]?, rhs: [T]?) {
    if let elements = rhs, elements.count > 0 {
        lhs = elements
    }
}
