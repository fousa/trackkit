//
//  Activity.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

/// Type of GPS fix. none means GPS had no fix. To signify "the fix info is unknown,
/// leave out fixType entirely. pps = military signal used.
public enum SportType: String {
    /// Active intentity
    case running = "Running"

    /// Resting intentity
    case biking = "Biking"

    /// Resting intentity
    case other = "Other"
}

/**
 An ordered list of points describing a path.
 */
public final class Activity {
    /// GPS name of track.
    public var id: String?

    /// Type (classification) of track.
    public var sport: SportType?

    public var laps: [Lap]?
}
