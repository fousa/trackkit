//
//  File.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import AEXML

extension File {

    convenience init(tcx rootElement: AEXMLElement) throws {
        // When the element is an error, don't create the instance.
        if rootElement.attributes["xmlns"] != "http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" {
            throw TrackParseError.invalidVersion
        }
        self.init()
        
        author <~ Person(tcx: rootElement["Author"])
    }

}
