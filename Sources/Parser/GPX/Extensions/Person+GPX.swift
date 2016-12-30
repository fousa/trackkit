//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Person: Gpxable {

    convenience init?(gpx element: AEXMLElement, version: TrackTypeVersion) {
        var rootElement = element
        if version.versionString == "1.1" {
            rootElement = element["author"]
        }

        // When the element is an error or doen't contain a name, don't create the instance.
        var nameKey = "author"
        if version.versionString == "1.1" {
            nameKey = "name"
        }
        if rootElement.error != nil || rootElement[nameKey].error != nil {
            return nil
        }
        self.init()

        if version.versionString == "1.0" {
            email <~ rootElement["email"]
            name  <~ rootElement["author"]
        } else if version.versionString == "1.1" {
            email = String(gpx: rootElement["email"])
            name  <~ rootElement["name"]
        }
        link <~ Link(gpx: rootElement, version: version)
    }

}
