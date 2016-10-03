//
//  Bounds.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import CoreLocation

/**
 Two coordinate defining the extent of an element.
*/
public final class Bounds {
    /// The minimum coordinate.
    public var minimumCoordinate: CLLocationCoordinate2D?

    /// The maximum coordinate.
    public var maximumCoordinate: CLLocationCoordinate2D?
}
