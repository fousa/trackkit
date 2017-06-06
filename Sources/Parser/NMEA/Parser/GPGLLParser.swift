//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import CoreLocation

class GPGLLParser: NMEAParsable {

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

        // Parse the coordinate and invalidate the point when not available.
        guard
            let latitude = parseCoordinateValue(from: self[1], direction: self[2], offset: 2),
            let longitude = parseCoordinateValue(from: self[3], direction: self[4], offset: 3) else {
                return nil
        }
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)

        // Parse the time.
        time = self[5]?.nmeaTimeValue

        // Parse the navigation receiver warning.
        navigationReceiverWarning = self[6]?.checksumEscapedString?.nmeaNavigationReceiverWarning
    }

}
