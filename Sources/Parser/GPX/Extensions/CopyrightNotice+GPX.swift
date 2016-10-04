//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension CopyrightNotice: Gpxable {
    
    convenience init?(gpx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        self.init()
        
        author = element.attributes["author"]
        
        year    <~ element["year"]
        license <~ element["license"]
    }
    
}
