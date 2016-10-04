//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//

import AEXML

protocol Gpxable: Parsable {
    init?(gpx element: AEXMLElement)
}
