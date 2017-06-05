//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import CoreLocation

protocol NMEAParsable {

    var line: [String] { get }

    var time: Date? { get }
    var coordinate: CLLocationCoordinate2D? { get }
    var gpsQuality: GPSQuality? { get }
    var numberOfSatellites: Int? { get }
    var horizontalDilutionOfPrecision: Double? { get }
    var meanSeaLevelHeight: Double? { get }
    var heightOfGeoid: Double? { get }
    var timeSinceLastUpdate: Double? { get }
    var stationId: String? { get }

    init?(line: [String])

}

extension NMEAParsable {

    subscript (index: Int) -> String? {
        return line.indices.contains(index) ? line[index] : nil
    }

}

class NMEAParser {

    // MARK: - Internals

    private let parser: NMEAParsable

    // MARK: - Properties

    var recordType: RecordType

    var time: Date? { return parser.time }
    var coordinate: CLLocationCoordinate2D? { return parser.coordinate }
    var gpsQuality: GPSQuality? { return parser.gpsQuality }
    var numberOfSatellites: Int? { return parser.numberOfSatellites }
    var horizontalDilutionOfPrecision: Double? { return parser.horizontalDilutionOfPrecision }
    var meanSeaLevelHeight: Double? { return parser.meanSeaLevelHeight }
    var heightOfGeoid: Double? { return parser.heightOfGeoid }
    var timeSinceLastUpdate: Double? { return parser.timeSinceLastUpdate }
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
        default:
            return nil
        }
    }
    
}
