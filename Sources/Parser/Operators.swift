//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import CoreLocation
import AEXML

precedencegroup OperatorPresedenceGroup {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator <~: OperatorPresedenceGroup

func <~ (lhs: inout String?, rhs: AEXMLElement) {
    lhs = rhs.optionalStringValue
}

func <~ (lhs: inout Int?, rhs: AEXMLElement) {
    lhs = rhs.optionalIntValue
}

func <~ (lhs: inout Float?, rhs: AEXMLElement) {
    lhs = rhs.optionalFloatValue
}

func <~ (lhs: inout CLLocationCoordinate2D?,
         rhs: (latitute: CLLocationDegrees, longitude: CLLocationDegrees)) {
    lhs = CLLocationCoordinate2DMake(rhs.latitute, rhs.longitude)
}

func <~ (lhs: inout [String]?, rhs: AEXMLElement) {
    lhs = rhs.optionalStringValue?.components(separatedBy: ",").map {
        $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

func <~ (lhs: inout Date?, rhs: AEXMLElement) {
    lhs = rhs.optionalStringValue?.isoDate() as Date?
}

func <~ (lhs: inout URL?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalStringValue {
        lhs = URL(string: stringValue)
    }
}

func <~ (lhs: inout FixType?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalStringValue {
        lhs = FixType(rawValue: stringValue)
    }
}
