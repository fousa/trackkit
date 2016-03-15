//
//  GKPoint.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import CoreLocation

struct GKPoint {
    var name: String?
    var comment: String?
    var description: String?
    var source: String?
    var symbol: String?
    var type: String?
    
    var satelites: Int?
    
    var elevation: Float?
    var meanSeaLevelHeight: Float?
    var horizontalDilutionOfPrecision: Float?
    var verticalDilutionOfPrecision: Float?
    var positionDilutionOfPrecision: Float?
    var ageOfTheGpxData: Float?
    
    var time: NSDate?
    
    var coordinate: CLLocationCoordinate2D?
    
    var link: GKLink?
}