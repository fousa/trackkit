//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Link: Gpxable {

    convenience init?(gpx element: AEXMLElement, version: TrackTypeVersion) {
        var rootElement = element
        if version.versionString == "1.1" {
            rootElement = element["link"]
        }

        // When the element is an error, don't create the instance.
        if rootElement.error != nil {
            return nil
        }

        var link: String?
        if version.versionString == "1.0" {
            link = rootElement["url"].optionalString
        } else if version.versionString == "1.1" {
            link = rootElement.attributes["href"]
        }
        guard let _ = link else {
            return nil
        }

        self.init()

        if version.versionString == "1.0" {
            text <~ rootElement["urlname"]
        } else if version.versionString == "1.1" {
            text     <~ rootElement["text"]
            mimeType <~ rootElement["type"]
        }
        self.link = link
    }

}
