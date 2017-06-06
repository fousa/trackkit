//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//
//

import AEXML

extension Point: Locable {

    convenience init?(loc element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
            return nil
        }

        // Check if coordinate is avaiable.
        let coordinateElement = element["coord"]
        guard
            let latitude = coordinateElement.attributes["lat"],
            let longitude = coordinateElement.attributes["lon"] else {
                return nil
        }
        self.init()

        coordinate  <~ (Double(latitude)!, Double(longitude)!)

        name        = element["name"].attributes["id"]
        description <~ element["name"]
        type        <~ element["type"]
        link        <~ Link(loc: element["link"])
    }

}
