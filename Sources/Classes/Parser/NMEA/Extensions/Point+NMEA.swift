//
//  Point+NMEA.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/06/2017.
//
//

import CoreLocation

extension Point {

    convenience init?(nmea line: [String]) {
        guard let parser = NMEAParser(line: line) else {
            return nil
        }
        self.init()

        recordType = parser.recordType
        name = parser.name
        time = parser.time
        coordinate = parser.coordinate
        gpsQuality = parser.gpsQuality
        navigationReceiverWarning = parser.navigationReceiverWarning
        numberOfSatellites = parser.numberOfSatellites
        horizontalDilutionOfPrecision = parser.horizontalDilutionOfPrecision
        elevation = parser.elevation
        heightOfGeoid = parser.heightOfGeoid
        timeSinceLastUpdate = parser.timeSinceLastUpdate
        speed = parser.speed
        magneticVariation = parser.magneticVariation
        trackAngle = parser.trackAngle
        stationId = parser.stationId
    }

}
