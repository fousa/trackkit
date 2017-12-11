//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 15/03/16.
//

/// The main file.
///
/// - important: Supported format: GPX, TCX, LOC
public final class File {
    /// Returns the value of the type that the file is parsed from.
    ///
    /// Here is an overview of available options:
    /// - gpx: A GPX formatted track.
    /// - loc: A LOC formatted track.
    /// - tcx: A TCX formatted track.
    public let type: TrackType

    /// Returns the version of the file type.
    public let typeVersion: TrackTypeVersion

    /// You must include the name or URL of the software that created your
    /// GPX document. This allows others to inform the creator of a GPX instance
    /// document that fails to validate.
    ///
    /// - important: Supported format: GPX
    public var creator: String?

    /// Source of data.
    ///
    /// - important: Supported format: LOC
    public var source: String?

    /// The name of the file.
    ///
    /// - important: Supported format: GPX
    public var name: String?

    /// A description of the contents of the GPX file.
    ///
    /// - important: Supported format: GPX
    public var description: String?

    /// The person or organization who created the GPX file.
    ///
    /// - important: Supported format: GPX
    public var author: Person?

    /// The application who created the TCX file.
    ///
    /// - important: Supported format: TCX
    public var applicationAuthor: Author?

    /// Copyright and license information governing use of the file.
    ///
    /// - important: Supported format: GPX
    public var copyrightNotice: CopyrightNotice?

    /// URLs associated with the location described in the file.
    ///
    /// - important: Supported format: GPX
    public var link: Link?

    /// The creation date of the file.
    ///
    /// - important: Supported format: GPX
    public var time: Date?

    /// Keywords associated with the file. Search engines or databases can use this
    /// information to classify the data.
    ///
    /// - important: Supported format: GPX
    public var keywords: [String]?

    /// Minimum and maximum coordinates which describe the extent of the coordinates
    /// in the file.
    ///
    /// - important: Supported format: GPX
    public var bounds: Bounds?

    /// A list of waypoints.
    ///
    /// - important: Supported format: GPX, LOC
    public var waypoints: [Point]?

    /// A list of routes.
    ///
    /// - important: Supported format: GPX
    public var routes: [Route]?

    /// A list of tracks.
    ///
    /// - important: Supported format: GPX
    public var tracks: [Track]?

    /// A list of courses.
    ///
    /// - important: Supported format: TCX
    public var courses: [Course]?

    /// A list of courses.
    ///
    /// - important: Supported format: TCX
    public var activities: [Activity]?

    /// A list of points.
    ///
    /// - important: Supported format: NMEA
    public var records: [Point]?
    
    /// A list of locations from the custom Track format.
    ///
    /// - important: Supported format: TRACK
    public var locations: [Point]?
    

    // MARK: - Init

    /// You have to initialize a file with a given `TrackType` and a `TrackTypeVersion`.
    init(type: TrackType, version: TrackTypeVersion) {
        self.type = type
        self.typeVersion = version
    }
}
