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
    case recordType
    case time
    case latitude
    case longitude
    case gpsQuality
    case numberOfSatellites
    case horizontalDilutionOfPrecision
    case meanSeaLevelHeight
    case heightOfGeoid
    case timeSinceLastUpdate
    case stationId

    var key: String {
        switch self {
        case .recordType:
            return "record_type"
        case .gpsQuality:
            return "gps_quality"
        case .numberOfSatellites:
            return "number_of_satellites"
        case .horizontalDilutionOfPrecision:
            return "horizontal_dilution_of_precision"
        case .meanSeaLevelHeight:
            return "mean_sea_level_height"
        case .heightOfGeoid:
            return "height_of_geoid"
        case .timeSinceLastUpdate:
            return "time_since_last_update"
        case .stationId:
            return "station_id"
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

fileprivate class Formatter {

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "HHmmss"
        return formatter
    }

}

extension RawDataType {

    fileprivate func parse(from rawValues: RawData) -> Any? {
        switch self {
        case .latitude:
            return parseCoordinate(from: rawValues, valueKey: "latitude", directionKey: "latitude_direction", degreesOffset: 2, reverser: "S")
        case .longitude:
            return parseCoordinate(from: rawValues, valueKey: "longitude", directionKey: "longitude_direction", degreesOffset: 3, reverser: "W")
        case .time:
            return parseTime(from: rawValues)
        case .stationId:
            return parseStationId(from: rawValues)
        default:
            return rawValues[mapping[self.key]]
        }
    }

    private func parseStationId(from rawValues: RawData) -> Any? {
        let id = rawValues[mapping[self.key]]
        return id?.components(separatedBy: "*").first
    }

    private func parseTime(from rawValues: RawData) -> Any? {
        guard let dateString = rawValues[mapping["time"]] else {
            return nil
        }

        let dateComponent = dateString.components(separatedBy: ".")
        guard let date = dateComponent.first else {
            return nil
        }

        return Formatter.timeFormatter.date(from: date)
        
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
            "time": 1,
            "latitude": 2,
            "latitude_direction": 3,
            "longitude": 4,
            "longitude_direction": 5,
            "gps_quality": 6,
            "number_of_satellites": 7,
            "horizontal_dilution_of_precision": 8,
            "mean_sea_level_height": 9,
            "height_of_geoid": 11,
            "time_since_last_update": 13,
            "station_id": 14
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
