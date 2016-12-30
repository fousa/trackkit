//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//
//

import AEXML

protocol Locable: Parsable {
    init?(loc element: AEXMLElement)
}
