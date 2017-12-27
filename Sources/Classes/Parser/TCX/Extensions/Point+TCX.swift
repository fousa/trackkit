//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

import AEXML

extension Point: Tcxable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
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
        cadence    <~ element["Cadence"]
        heartRate  <~ element["HeartRateBpm"]["Value"]
        time       <~ element["Time"]
    }

}
