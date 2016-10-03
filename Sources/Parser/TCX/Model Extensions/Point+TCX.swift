//
//  Point+TCX.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

import AEXML

extension Point: TCXable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }

        // Check if coordinate is avaiable.
        guard
            let latitude = element["Position"]["LatitudeDegrees"].optionalDouble,
            let longitude = element["Position"]["LongitudeDegrees"].optionalDouble else {
                return nil
        }
        self.init()

        coordinate <~ (latitude, longitude)
        elevation  <~ element["AltitudeMeters"]
        distance   <~ element["DistanceMeters"]
        time       <~ element["Time"]
    }

}
