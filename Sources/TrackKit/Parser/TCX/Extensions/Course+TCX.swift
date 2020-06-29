//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

import AEXML

extension Course: Tcxable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
            return nil
        }

        // When there are not route points, don't create the instance.
        var routePoints: [Point]? = nil
        routePoints <~ element["Track"]["Trackpoint"].all?.compactMap { Point(tcx: $0) }
        if routePoints == nil {
            return nil
        }

        self.init()

        name          <~ element["Name"]
        totalTime     <~ element["Lap"]["TotalTimeSeconds"]
        totalDistance <~ element["Lap"]["DistanceMeters"]
        intensity     <~ element["Lap"]["Intensity"]
        if
            let latitude = element["Lap"]["BeginPosition"]["LatitudeDegrees"].optionalDouble,
            let longitude = element["Lap"]["BeginPosition"]["LongitudeDegrees"].optionalDouble {
            beginPosition <~ (latitude, longitude)
        }
        if
            let latitude = element["Lap"]["EndPosition"]["LatitudeDegrees"].optionalDouble,
            let longitude = element["Lap"]["EndPosition"]["LongitudeDegrees"].optionalDouble {
            endPosition <~ (latitude, longitude)
        }
        points = routePoints
    }

}
