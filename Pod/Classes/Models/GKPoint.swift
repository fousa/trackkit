//
//  GKPoint.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import CoreLocation

public struct GKPoint {
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