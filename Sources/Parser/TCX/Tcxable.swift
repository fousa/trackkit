//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//

import AEXML

protocol Tcxable: XMLParsable {
    init?(tcx element: AEXMLElement)
}
