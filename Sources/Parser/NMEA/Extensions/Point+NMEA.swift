//
//  Point+NMEA.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/06/2017.
//
//

import Foundation

extension Point {

    convenience init?(nmea rawData: RawData) {
        // When the data is empty, don't create the instance.
        if rawData.isEmpty {
            return nil
        }

        // Check if coordinate is avaiable.
        guard
            let latitude = rawData[.latitude] as? Double,
            let longitude = rawData[.longitude] as? Double else {
                return nil
        }
        self.init()

        recordType <~ rawData[.recordType]
        coordinate <~ (latitude, longitude)
    }
    
}

