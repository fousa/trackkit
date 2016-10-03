//
//  Lap.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

import Foundation

/// A Track Segment holds a list of Track Points which are logically connected in
/// order. To represent a single GPS track where GPS reception was lost, or the GPS
/// receiver was turned off, start a new Track Segment for each continuous span of
/// track data.
public final class Lap {
    public var startTime: Date?

    /// Total time in seconds.
    public var totalTime: Double?

    /// Total distance in meters.
    public var totalDistance: Double?

    /// Total distance in meters.
    public var maximumSpeed: Double?

    /// Total distance in meters.
    public var calories: Int?

    /// Total distance in meters.
    public var averageHeartRate: Int?

    /// Total distance in meters.
    public var maximumHeartRate: Int?

    /// Total distance in meters.
    public var cadence: Int?

    /// Intensity of the route.
    public var intensity: IntentityType?

    /// Intensity of the route.
    public var triggerMethod: String?

    /// A list of route points.
    public var points: [Point]?
}
