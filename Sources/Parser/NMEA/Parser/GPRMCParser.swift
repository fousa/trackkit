//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import CoreLocation

class GPRMCParser: NMEAParsable {

    private(set) var line: [String]

    private(set) var name: String?
    private(set) var time: Date?
    private(set) var coordinate: CLLocationCoordinate2D?
    private(set) var gpsQuality: GPSQuality?
    private(set) var navigationReceiverWarning: NavigationReceiverWarning?
    private(set) var numberOfSatellites: Int?
    private(set) var horizontalDilutionOfPrecision: Double?
    private(set) var elevation: Double?
    private(set) var heightOfGeoid: Double?
    private(set) var timeSinceLastUpdate: Double?
    private(set) var speed: Double?
    private(set) var trackAngle: Double?
    private(set) var magneticVariation: Double?
    private(set) var stationId: String?

    required init?(line: [String]) {
        self.line = line

        // Parse the time.
        time = parseTime()

        // Parse the coordinate and invalidate the point when not available.
        guard
            let latitude = parseCoordinateValue(from: self[3], direction: self[4], offset: 2),
            let longitude = parseCoordinateValue(from: self[5], direction: self[6], offset: 3) else {
                return nil
        }
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)

        // Parse the navigation receiver warning.
        navigationReceiverWarning = self[2]?.nmeaNavigationReceiverWarning

        // Parse the main properties.
        speed = self[7]?.doubleValue
        trackAngle = self[8]?.doubleValue
        magneticVariation = self[10]?.doubleValue
        if
            let magneticVariation = magneticVariation,
            let variationDirection = self[11]?.checksumEscapedString,
            variationDirection == "W" {
            self.magneticVariation = magneticVariation * -1.0
        }
    }

    // MARK: - Helpers

    private static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "ddMMyyHHmmss"
        return formatter
    }

    private func parseTime() -> Date? {
        guard
            let rawTime = self[1],
            let rawDate = self[9] else {
            return nil
        }

        return GPRMCParser.timeFormatter.date(from: "\(rawDate)\(rawTime)")
    }

}
