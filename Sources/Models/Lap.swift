//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

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
/// - important: Supported format: TCX
public final class Lap {
    /// The start time.
    public var startTime: Date?

    /// Total time in seconds.
    public var totalTime: Double?

    /// Total distance in meters.
    public var totalDistance: Double?

    /// The maximum speed.
    public var maximumSpeed: Double?

    /// Total calories burned.
    public var calories: Int?

    /// The average heartrate.
    public var averageHeartRate: Int?

    /// The maximum heartrate.
    public var maximumHeartRate: Int?

    /// The average cadence.
    public var cadence: Int?

    /// Intensity of the lap.
    public var intensity: Intentity?

    /// The trigger method.
    public var triggerMethod: TriggerMethod?

    /// A list of lap points.
    public var points: [Point]?
}
