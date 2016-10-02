//
//  Route.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import AEXML

/**
 An ordered list of waypoints representing a series of turn points leading to a destination.
*/
public final class Route {
    /// GPS name of route.
    public var name: String?

    /// GPS comment for route.
    public var comment: String?

    /// Text description of route for user. Not sent to GPS.
    public var description: String?

    /// Source of data. Included to give user some idea of reliability and accuracy of data.
    public var source: String?

    /// Links to external information about the route.
    public var link: Link?

    /// GPS route number.
    public var number: Int?

    /// Type (classification) of route.
    public var type: String?

    /// Lap information for the course. _TCX only_
    public var lap: Lap?

    /// A list of route points.
    public var points: [Point]?
}
