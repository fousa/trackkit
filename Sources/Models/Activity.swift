//
//  Activity.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

/**
 An ordered list of points describing a path.
 */
public final class Activity {
    /// GPS name of track.
    public var id: String?

    /// Type (classification) of track.
    public var sport: String?

    public var laps: [Lap]?
}
