//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

import Foundation

/// The trigger method defines how activity is started or paused.
///
/// - important: Supported format: TCX
public enum TriggerMethod: String {
    /// Manually
    case manual = "Manual"

    /// By distance
    case distance = "Distance"

    /// By location
    case location = "Location"

    /// On time
    case time = "Time"

    /// By heartrate
    case heartRate = "HeartRate"
}

/// A lap contains a series of points that define how one's performance
/// was during that entire lap. A course can contain multiple laps.
///
/// - important: Supported format: TCX, FIT
public final class Lap {
    /// The start time.
    ///
    /// - important: Supported format: TCX, FIT
    public var startTime: Date?

    /// Total time in seconds.
    ///
    /// - important: Supported format: TCX, FIT
    public var totalTime: Double?

    /// Total distance in meters.
    ///
    /// - important: Supported format: TCX, FIT
    public var totalDistance: Double?

    /// The maximum speed.
    ///
    /// - important: Supported format: TCX, FIT
    public var maximumSpeed: Double?

    /// Total calories burned.
    ///
    /// - important: Supported format: TCX, FIT
    public var calories: Int?

    /// The average heartrate.
    ///
    /// - important: Supported format: TCX, FIT
    public var averageHeartRate: Int?

    /// The maximum heartrate.
    ///
    /// - important: Supported format: TCX, FIT
    public var maximumHeartRate: Int?

    /// The average cadence.
    ///
    /// - important: Supported format: TCX, FIT
    public var cadence: Int?

    /// Intensity of the lap.
    ///
    /// - important: Supported format: TCX
    public var intensity: Intentity?

    /// The trigger method.
    ///
    /// - important: Supported format: TCX
    public var triggerMethod: TriggerMethod?

    /// A list of lap points.
    ///
    /// - important: Supported format: TCX, FIT
    public var points: [Point]?
}
