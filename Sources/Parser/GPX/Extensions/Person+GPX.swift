//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Person: Gpxable {
    
    convenience init?(gpx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        self.init()
        
        email = String(gpx: element["email"])
        
        name  <~ element["name"]
        link  <~ Link(gpx: element["link"])
    }
    
}
