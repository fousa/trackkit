//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

import AEXML

extension Activity: Tcxable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
            return nil
        }

        // When there are not route points, don't create the instance.
        var laps: [Lap]? = nil
        laps <~ element["Lap"].all?.compactMap { Lap(tcx: $0) }
        if laps == nil {
            return nil
        }

        self.init()

        identifier <~ element["Id"]
        sport      <~ element.attributes["Sport"]
        self.laps = laps
    }

}
