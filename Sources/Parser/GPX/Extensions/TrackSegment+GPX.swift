//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension TrackSegment: Gpxable {
    
    convenience init?(gpx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        
        // When there are not route points, don't create the instance.
        var trackPoints: [Point]? = nil
        trackPoints <~ element["trkpt"].all?.flatMap { Point(gpx: $0) }
        if trackPoints == nil {
            return nil
        }
        self.init()
        
        points = trackPoints
    }
    
}
