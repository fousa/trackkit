//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension File {

    convenience init(tcx rootElement: AEXMLElement) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .tcx, version: rootElement.attributes["xmlns"])
        self.init(type: .tcx, version: version)

        applicationAuthor <~ Author(tcx: rootElement["Author"])
        courses           <~ rootElement["Courses"]["Course"].all?.flatMap { Course(tcx: $0) }
        activities        <~ rootElement["Activities"]["Activity"].all?.flatMap { Activity(tcx: $0) }
    }

}
