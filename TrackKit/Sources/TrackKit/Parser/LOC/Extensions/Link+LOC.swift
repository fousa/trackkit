//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//
//

import AEXML

extension Link: Locable {

    convenience init?(loc element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
            return nil
        }
        self.init()

        text = element.attributes["text"]
        link <~ element
    }

}
