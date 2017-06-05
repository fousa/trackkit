//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

import CoreLocation
import AEXML

protocol XMLParsable {}

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
    lhs <~ rhs.optionalString
}

func <~ <T>(lhs: inout T?, rhs: T?) {
    lhs = rhs
}

func <~ (lhs: inout Date?, rhs: String?) {
    lhs = (rhs?.isoDate() ?? rhs?.isoDateWithMilliseconds()) as Date?
}

func <~ (lhs: inout URL?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = URL(string: stringValue)
    }
}

// MARK: - Enums

func <~ (lhs: inout Intentity?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = Intentity(rawValue: stringValue)
    }
}

func <~ (lhs: inout Fix?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = Fix(rawValue: stringValue)
    }
}

func <~ (lhs: inout Sport?, rhs: String?) {
    if let stringValue = rhs {
        lhs = Sport(rawValue: stringValue)
    }
}

func <~ (lhs: inout TriggerMethod?, rhs: AEXMLElement) {
    if let stringValue = rhs.optionalString {
        lhs = TriggerMethod(rawValue: stringValue)
    }
}

// MARK: - Relations

func <~ <T: XMLParsable>(lhs: inout T?, rhs: T?) {
    lhs = rhs
}

func <~ <T: XMLParsable>(lhs: inout [T]?, rhs: [T]?) {
    if let elements = rhs, elements.count > 0 {
        lhs = elements
    }
}
