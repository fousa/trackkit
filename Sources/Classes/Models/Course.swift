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
/// - important: Supported format: TCX, FIT
public final class Course {
    /// Name of the course.
    ///
    /// - important: Supported format: TCX
    public var name: String?

    /// Total time in seconds.
    ///
    /// - important: Supported format: TCX
    public var totalTime: Double?

    /// Total distance in meters.
    ///
    /// - important: Supported format: TCX
    public var totalDistance: Double?

    /// The coordinate of the begin position.
    ///
    /// - important: Supported format: TCX
    public var beginPosition: CLLocationCoordinate2D?

    /// The coordinate of the end position.
    ///
    /// - important: Supported format: TCX
    public var endPosition: CLLocationCoordinate2D?

    /// Intensity of the route.
    ///
    /// - important: Supported format: TCX
    public var intensity: Intentity?

    /// A list of course points.
    ///
    /// - important: Supported format: TCX, FIT
    public var points: [Point]?
}
