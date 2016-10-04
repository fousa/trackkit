//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

import AEXML

extension String {

    init?(gpx element: AEXMLElement) {
        guard
            let id = element.attributes["id"],
            let domain = element.attributes["domain"] else {
            return nil
        }

        self = "\(id)@\(domain)"
    }

}
