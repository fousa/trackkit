//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

import AEXML

extension Lap: Tcxable {

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

        startTime        <~ element.attributes["StartTime"]
        totalTime        <~ element["TotalTimeSeconds"]
        totalDistance    <~ element["DistanceMeters"]
        maximumSpeed     <~ element["MaximumSpeed"]
        calories         <~ element["Calories"]
        averageHeartRate <~ element["AverageHeartRateBpm"]["Value"]
        maximumHeartRate <~ element["MaximumHeartRateBpm"]["Value"]
        cadence          <~ element["Cadence"]
        triggerMethod    <~ element["TriggerMethod"]
        intensity        <~ element["Intensity"]
        points           = routePoints
    }

}
