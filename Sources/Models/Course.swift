//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

import CoreLocation

/// The intensity definition.
///
/// - important: Supported format: TCX
public enum Intentity: String {
    /// Active intentity
    case active = "Active"

    /// Resting intentity
    case resting = "Resting"
}

/// An ordered list of points representing your defined course.
///
/// - important: Supported format: TCX
public final class Course {
    /// Name of the course.
    public var name: String?

    /// Total time in seconds.
    public var totalTime: Double?

    /// Total distance in meters.
    public var totalDistance: Double?

    /// The coordinate of the begin position.
    public var beginPosition: CLLocationCoordinate2D?

    /// The coordinate of the end position.
    public var endPosition: CLLocationCoordinate2D?

    /// Intensity of the route.
    public var intensity: Intentity?

    /// A list of course points.
    public var points: [Point]?
}
