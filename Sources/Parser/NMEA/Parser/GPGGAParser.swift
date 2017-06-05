//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import CoreLocation

class GPGGAParser: NMEAParsable {

    private(set) var line: [String]

    private(set) var time: Date?
    private(set) var coordinate: CLLocationCoordinate2D?
    private(set) var gpsQuality: GPSQuality?
    private(set) var numberOfSatellites: Int?
    private(set) var horizontalDilutionOfPrecision: Double?
    private(set) var meanSeaLevelHeight: Double?
    private(set) var heightOfGeoid: Double?
    private(set) var timeSinceLastUpdate: Double?
    private(set) var stationId: String?

    required init?(line: [String]) {
        self.line = line

        // Parse the time.
        time = self[1]?.nmeaTimeValue

        // Parse the coordinate and invalidate the point when not available.
        guard
            let latitude = parseCoordinateValue(from: self[2], direction: self[3], offset: 2),
            let longitude = parseCoordinateValue(from: self[4], direction: self[5], offset: 3) else {
                return nil
        }
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)

        // Parse the GPX quality.
        gpsQuality = self[6]?.nmeaGPSQuality

        // Parse the main properties.
        numberOfSatellites = self[7]?.integerValue
        horizontalDilutionOfPrecision = self[8]?.doubleValue
        meanSeaLevelHeight = self[9]?.doubleValue
        heightOfGeoid = self[11]?.doubleValue
        timeSinceLastUpdate = self[13]?.doubleValue

        // Parse the station id without the checksum.
        stationId = self[14]?.components(separatedBy: "*").first
    }

    // MARK: - Helpers

    private func parseCoordinateValue(from value: String?, direction: String?, offset: Int) -> CLLocationDegrees? {
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
