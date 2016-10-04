//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

/// An ordered list of waypoints representing a series of turn points leading to a destination.
///
/// - important: Supported format: GPX
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

    /// A list of route points.
    public var points: [Point]?
}
