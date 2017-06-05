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

        self.recordType = parser.recordType
        self.time = parser.time
        self.coordinate = parser.coordinate
        self.gpsQuality = parser.gpsQuality
        self.numberOfSatellites = parser.numberOfSatellites
        self.horizontalDilutionOfPrecision = parser.horizontalDilutionOfPrecision
        self.meanSeaLevelHeight = parser.meanSeaLevelHeight
        self.heightOfGeoid = parser.heightOfGeoid
        self.timeSinceLastUpdate = parser.timeSinceLastUpdate
        self.stationId = parser.stationId
    }
    
}
