//
//  Lap+TCX.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

import AEXML

extension Lap: TCXable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }

        self.init()

        totalTime     <~ element["TotalTimeSeconds"]
        totalDistance <~ element["DistanceMeters"]
        intensity     <~ element["Intensity"]

        // Check if begin coordinate is avaiable.
        if
            let latitude = element["BeginPosition"]["LatitudeDegrees"].optionalDouble,
            let longitude = element["BeginPosition"]["LongitudeDegrees"].optionalDouble {
            beginPosition <~ (latitude, longitude)
        }
        // Check if end coordinate is avaiable.
        if
            let latitude = element["EndPosition"]["LatitudeDegrees"].optionalDouble,
            let longitude = element["EndPosition"]["LongitudeDegrees"].optionalDouble {
            endPosition <~ (latitude, longitude)
        }
    }

}
