//
//  RawData.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/06/2017.
//
//

import Foundation

protocol RawData {
}

extension Array: RawData {
}

enum RawDataType {
    case latitude
    case longitude
    case recordType

    var key: String {
        switch self {
        case .recordType:
            return "record_type"
        default:
            return "unknown"
        }
    }
}

extension RawData {

    var isEmpty: Bool {
        return ((self as? [String])?.count ?? 0) == 0
    }

    subscript(key: RawDataType) -> Any? {
        return key.parse(from: self)
    }

    fileprivate subscript(index: Int?) -> String? {
        guard
            let index = index,
            let array = self as? [String] else {
                return nil
        }
        return array.indices.contains(index) ? array[index] : nil
    }

}

extension RawDataType {

    fileprivate func parse(from rawValues: RawData) -> Any? {
        switch self {
        case .latitude:
            return parseCoordinate(from: rawValues, valueKey: "latitude", directionKey: "latitude_direction", degreesOffset: 2, reverser: "S")
        case .longitude:
            return parseCoordinate(from: rawValues, valueKey: "longitude", directionKey: "longitude_direction", degreesOffset: 3, reverser: "W")
        default:
            return rawValues[mapping[self.key]]
        }
    }

    private func parseCoordinate(from rawValues: RawData, valueKey: String, directionKey: String, degreesOffset: Int, reverser: String) -> Double? {
        let rawValue = rawValues[mapping[valueKey]]
        let directionRawValue = rawValues[mapping[directionKey]]

        guard
            let degrees = rawValue?[0..<degreesOffset],
            let degreesValue = Double(degrees),
            let startIndex = rawValue?.startIndex,
            let index = rawValue?.index(startIndex, offsetBy: degreesOffset),
            let minutes = rawValue?.substring(from: index),
            let minutesValue = Double(minutes) else {
                return nil
        }

        let isReversed = directionRawValue == reverser
        return (degreesValue + minutesValue / 60.0) * (isReversed ? -1.0 : 1.0)
    }

    private var mapping: [String: Int] {
        return [
            "record_type": 0,
            "latitude": 2,
            "latitude_direction": 3,
            "longitude": 4,
            "longitude_direction": 5
        ]
    }
    
}

extension String {

    fileprivate subscript (r: Range<Int>) -> String? {
        guard
            let start = index(startIndex, offsetBy: r.lowerBound, limitedBy: endIndex),
            let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound, limitedBy: endIndex) else {
                return nil
        }

        return self[Range(start ..< end)]
    }
    
}
