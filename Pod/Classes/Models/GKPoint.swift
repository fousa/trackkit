//
//  GKPoint.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

public final class GKPoint {
    public var name: String?
    public var comment: String?
    public var description: String?
    public var source: String?
    public var symbol: String?
    public var type: String?
    
    public var satelites: Int?
    
    public var elevation: Float?
    public var meanSeaLevelHeight: Float?
    public var horizontalDilutionOfPrecision: Float?
    public var verticalDilutionOfPrecision: Float?
    public var positionDilutionOfPrecision: Float?
    public var ageOfTheGpxData: Float?
    
    public var time: NSDate?
    
    public var coordinate: CLLocationCoordinate2D?
    
    public var link: GKLink?
}

extension GKPoint: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        
        // Check if coordinate is avaiable.
        guard let latitude = element.attributes["lat"], let longitude = element.attributes["lon"] else {
            return nil
        }
        self.init()
        
        coordinate                    <~ (Double(latitude)!, Double(longitude)!)
        elevation                     <~ element["ele"]
        meanSeaLevelHeight            <~ element["geoidheight"]
        name                          <~ element["name"]
        comment                       <~ element["cmt"]
        description                   <~ element["desc"]
        source                        <~ element["src"]
        symbol                        <~ element["sym"]
        type                          <~ element["type"]
        satelites                     <~ element["sat"]
        horizontalDilutionOfPrecision <~ element["hdop"]
        verticalDilutionOfPrecision   <~ element["vdop"]
        positionDilutionOfPrecision   <~ element["pdop"]
        ageOfTheGpxData               <~ element["ageofdgpsdata"]
        time                          <~ element["time"]
        link                          <~ element["link"]
    }
    
}