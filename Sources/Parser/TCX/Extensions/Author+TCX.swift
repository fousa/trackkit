//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/09/2016.
//

import AEXML

extension Author: Tcxable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.error != nil {
            return nil
        }
        self.init()

        name       <~ element["Name"]
        version    <~ Version(tcx: element["Build"]["Version"])
        language   <~ element["LangID"]
        partNumber <~ element["PartNumber"]
    }

}
