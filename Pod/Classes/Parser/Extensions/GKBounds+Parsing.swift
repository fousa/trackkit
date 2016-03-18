//
//  GKBounds+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

extension GKBounds {
    
    init?(fromElement element: AEXMLElement) {
        // When the element misses some coordinate data, don't create the link instance.
        guard let minimumLatitude = element.attributes["minlat"], let minimumLongitude = element.attributes["minlon"], let maximumLatitude = element.attributes["maxlat"], let maximumLongitude = element.attributes["maxlon"] else {
            return nil
        }
        
        minimumCoordinate = CLLocationCoordinate2DMake(Double(minimumLatitude)!, Double(minimumLongitude)!)
        maximumCoordinate = CLLocationCoordinate2DMake(Double(maximumLatitude)!, Double(maximumLongitude)!)
    }
    
}