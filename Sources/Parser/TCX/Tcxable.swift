//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//

import AEXML

protocol Tcxable: Parsable {
    init?(tcx element: AEXMLElement)
}
