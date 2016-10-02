//
//  Lap.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 02/10/2016.
//
//

import CoreLocation

/// Type of GPS fix. none means GPS had no fix. To signify "the fix info is unknown,
/// leave out fixType entirely. pps = military signal used.
public enum IntentityType: String {
    /// Active intentity
    case active = "Active"

    /// Resting intentity
    case resting = "Resting"
}

/**
 An ordered list of waypoints representing a series of turn points leading to a destination.
 */
public final class Lap {
    /// Total time in seconds.
    public var totalTime: Float?

    /// Total distance in meters.
    public var totalDistance: Float?

    /// The coordinate of the begin position.
    public var beginPosition: CLLocationCoordinate2D?

    /// The coordinate of the end position.
    public var endPosition: CLLocationCoordinate2D?

    /// Intensity of the route.
    public var intensity: IntentityType?
}
