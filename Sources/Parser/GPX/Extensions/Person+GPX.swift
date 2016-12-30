//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

import AEXML

extension Person: Gpxable {

    convenience init?(gpx element: AEXMLElement, version: TrackTypeVersion) {
        // Define the root element.
        let rootElement = Person.rootElement(for: version, element: element)

        // When the element is an error, don't create the instance.
        guard Person.validate(element: rootElement, for: version) else {
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

    // MARK: - Helpers

    private static func rootElement(for version: TrackTypeVersion, element: AEXMLElement) -> AEXMLElement {
        if version.versionString == "1.1" {
            return element["author"]
        }
        return element
    }

    private static func validate(element: AEXMLElement, for version: TrackTypeVersion) -> Bool {
        // When the element is an error, don't create the instance.
        guard element.error == nil else {
            return false
        }

        if version.versionString == "1.0" {
            return element["author"].optionalString != nil
        } else if version.versionString == "1.1" {
            return element["name"].optionalString != nil
        }

        return false
    }

}
