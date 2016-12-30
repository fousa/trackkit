//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Bounds: Gpxable {

    convenience init?(gpx element: AEXMLElement, version: TrackTypeVersion) {
        // When the element misses some coordinate data, don't create the instance.
        guard
            let minimumLatitude = element.attributes["minlat"],
            let minimumLongitude = element.attributes["minlon"],
            let maximumLatitude = element.attributes["maxlat"],
            let maximumLongitude = element.attributes["maxlon"] else {
                return nil
        }
        self.init()

        minimumCoordinate <~ (Double(minimumLatitude)!, Double(minimumLongitude)!)
        maximumCoordinate <~ (Double(maximumLatitude)!, Double(maximumLongitude)!)
    }

}
