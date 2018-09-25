//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Route: Gpxable {

    convenience init?(gpx element: AEXMLElement, version: TrackTypeVersion) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
            return nil
        }

        // When there are not route points, don't create the instance.
        var routePoints: [Point]? = nil
        routePoints <~ element["rtept"].all?.compactMap { Point(gpx: $0, version: version) }
        if routePoints == nil {
            return nil
        }

        self.init()

        name        <~ element["name"]
        comment     <~ element["cmt"]
        description <~ element["desc"]
        source      <~ element["src"]
        number      <~ element["number"]
        type        <~ element["type"]
        link        <~ Link(gpx: element, version: version)
        points      = routePoints
    }

}
