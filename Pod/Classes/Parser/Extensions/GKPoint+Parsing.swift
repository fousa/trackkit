//
//  GKPoint+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

extension GKPoint {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the link instance.
        if element.errored { return nil }
        
        // Check if coordinate is avaiable.
        guard let latitude = element.attributes["lat"], let longitude = element.attributes["lon"] else {
            return nil
        }
        
        coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        elevation = element["ele"].optionalFloatValue
        meanSeaLevelHeight = element["geoidheight"].optionalFloatValue
        name = element["name"].optionalValue
        comment = element["cmt"].optionalValue
        description = element["desc"].optionalValue
        source = element["src"].optionalValue
        symbol = element["sym"].optionalValue
        type = element["type"].optionalValue
        satelites = element["sat"].optionalIntValue
        horizontalDilutionOfPrecision = element["hdop"].optionalFloatValue
        verticalDilutionOfPrecision = element["vdop"].optionalFloatValue
        positionDilutionOfPrecision = element["pdop"].optionalFloatValue
        ageOfTheGpxData = element["ageofdgpsdata"].optionalFloatValue
        
        // Parse the time.
        time = nil
        if let timeString = element["time"].optionalValue {
            time = NSDate(fromString: timeString, format: .ISO8601(nil))
        }
        
        // Parse the metadata link.
        link = GKLink(fromElement: element["link"])
    }
    
}