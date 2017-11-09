//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import CoreLocation

protocol NMEAParsable {

    var line: [String] { get }

    var name: String? { get }
    var time: Date? { get }
    var coordinate: CLLocationCoordinate2D? { get }
    var gpsQuality: GPSQuality? { get }
    var navigationReceiverWarning: NavigationReceiverWarning? { get }
    var numberOfSatellites: Int? { get }
    var horizontalDilutionOfPrecision: Double? { get }
    var elevation: Double? { get }
    var heightOfGeoid: Double? { get }
    var timeSinceLastUpdate: Double? { get }
    var speed: Double? { get }
    var trackAngle: Double? { get }
    var magneticVariation: Double? { get }
    var stationId: String? { get }

    init?(line: [String])

}

#if swift(>=4.0)
    private extension String {
        func substring(from: String.Index) -> String {
            return String(self[from...])
        }
    }
#endif

extension NMEAParsable {

    subscript (index: Int) -> String? {
        return line.indices.contains(index) ? line[index] : nil
    }

    // MARK: - Helpers

    func parseCoordinateValue(from value: String?, direction: String?, offset: Int) -> CLLocationDegrees? {
        guard
            let degrees = value?[0..<offset],
            let degreesValue = Double(degrees),
            let startIndex = value?.startIndex,
            let index = value?.index(startIndex, offsetBy: offset),
            let minutes = value?.substring(from: index),
            let minutesValue = Double(minutes) else {
            return nil
        }

        let isReversed = direction == "S" || direction == "W"
        return (degreesValue + minutesValue / 60.0) * (isReversed ? -1.0 : 1.0)
    }

}

extension RecordType {

    var isWaypoint: Bool {
        switch self {
        case .wpl:
            return true
        default:
            return false
        }
    }

}

class NMEAParser {

    // MARK: - Internals

    private let parser: NMEAParsable

    // MARK: - Properties

    var recordType: RecordType

    var name: String? { return parser.name }
    var time: Date? { return parser.time }
    var coordinate: CLLocationCoordinate2D? { return parser.coordinate }
    var gpsQuality: GPSQuality? { return parser.gpsQuality }
    var navigationReceiverWarning: NavigationReceiverWarning? { return parser.navigationReceiverWarning }
    var numberOfSatellites: Int? { return parser.numberOfSatellites }
    var horizontalDilutionOfPrecision: Double? { return parser.horizontalDilutionOfPrecision }
    var elevation: Double? { return parser.elevation }
    var heightOfGeoid: Double? { return parser.heightOfGeoid }
    var timeSinceLastUpdate: Double? { return parser.timeSinceLastUpdate }
    var speed: Double? { return parser.speed }
    var trackAngle: Double? { return parser.trackAngle }
    var magneticVariation: Double? { return parser.magneticVariation }
    var stationId: String? { return parser.stationId }

    // MARK: - Init

    init?(line: [String]) {
        guard
            let rawRecordType = line.first,
            let recordType = RecordType(rawValue: rawRecordType),
            let parser = recordType.parser(for: line) else {
            return nil
        }

        self.recordType = recordType
        self.parser = parser
    }

}

extension RecordType {

    func parser(for line: [String]) -> NMEAParsable? {
        switch self {
        case .gga:
            return GPGGAParser(line: line)
        case .rmc:
            return GPRMCParser(line: line)
        case .gll:
            return GPGLLParser(line: line)
        case .wpl:
            return GPWPLParser(line: line)
        }
    }

}
