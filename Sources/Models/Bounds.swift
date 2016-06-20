//
//  GKBounds.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

/**
 Two coordinate defining the extent of an element.
*/
public final class Bounds {
    /// The minimum coordinate.
    public var minimumCoordinate: CLLocationCoordinate2D?
    
    /// The maximum coordinate.
    public var maximumCoordinate: CLLocationCoordinate2D?
}

extension Bounds: Mappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element misses some coordinate data, don't create the instance.
        guard let minimumLatitude = element.attributes["minlat"], let minimumLongitude = element.attributes["minlon"], let maximumLatitude = element.attributes["maxlat"], let maximumLongitude = element.attributes["maxlon"] else {
            return nil
        }
        self.init()
        
        minimumCoordinate <~ (Double(minimumLatitude)!, Double(minimumLongitude)!)
        maximumCoordinate <~ (Double(maximumLatitude)!, Double(maximumLongitude)!)
    }
    
}