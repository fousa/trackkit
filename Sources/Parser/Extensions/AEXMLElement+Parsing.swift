//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

import AEXML

extension AEXMLElement {

    var optionalString: String? {
        if error != nil {
            return nil
        }
        return value
    }

    var optionalInt: Int? {
        if error != nil {
            return nil
        }
        return int
    }

    var optionalDouble: Double? {
        if error != nil {
            return nil
        }
        return double
    }

}
