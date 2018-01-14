//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

/// Type of sport that was performed during the activity.
///
/// - important: Supported format: TCX
public enum Sport: String {
    /// Running activity type.
    case running = "Running"

    /// Biking activity type.
    case biking = "Biking"

    /// Other activity type.
    case other = "Other"
}

/// This is an activity as defined in the TCX file.
///
/// - important: Supported format: TCX, FIT
public final class Activity {
    /// The id if the activity.
    ///
    /// - important: Supported format: TCX
    public var identifier: String?

    /// Type of sport performed.
    ///
    /// - important: Supported format: TCX
    public var sport: Sport?

    /// The number of laps an activity includes.
    ///
    /// - important: Supported format: TCX, FIT
    public var laps: [Lap]?
}
