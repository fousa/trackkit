//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Link: Gpxable {

    convenience init?(gpx element: AEXMLElement, version: TrackTypeVersion) {
        // Define the root element.
        let rootElement = Link.rootElement(for: version, element: element)

        // When the element is an error, don't create the instance.
        guard Link.validate(element: rootElement, for: version) else {
            return nil
        }
        self.init()

        if version.versionString == "1.0" {
            link <~ rootElement["url"]
            text <~ rootElement["urlname"]
        } else if version.versionString == "1.1" {
            link = rootElement.attributes["href"]
            text     <~ rootElement["text"]
            mimeType <~ rootElement["type"]
        }
    }

    // MARK: - Helpers

    private static func rootElement(for version: TrackTypeVersion, element: AEXMLElement) -> AEXMLElement {
        if version.versionString == "1.1" {
            return element["link"]
        }
        return element
    }

    private static func validate(element: AEXMLElement, for version: TrackTypeVersion) -> Bool {
        // When the element is an error, don't create the instance.
        guard element.error == nil else {
            return false
        }

        if version.versionString == "1.0" {
            return element["url"].optionalString != nil
        } else if version.versionString == "1.1" {
            return element.attributes["href"] != nil
        }

        return false
    }

}
