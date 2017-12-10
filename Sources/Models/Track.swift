//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 16/03/16.
//

/// An ordered list of points describing a path.
///
/// - important: Supported format: GPX
public final class Track {
    /// GPS name of track.
    public var name: String?

    /// GPS comment for track.
    public var comment: String?

    /// User description of track.
    public var description: String?

    /// Source of data. Included to give user some idea of reliability and accuracy of data.
    public var source: String?

    /// Links to external information about track.
    public var link: Link?

    /// GPS track number.
    public var number: Int?

    /// Type (classification) of track.
    public var type: String?

    /// A Track Segment holds a list of Track Points which are logically connected in
    /// order. To represent a single GPS track where GPS reception was lost, or the
    /// GPS receiver was turned off, start a new Track Segment for each continuous span
    /// of track data.
    public var segments: [TrackSegment]?
    
    /// A Track Point holds the coordinates, elevation, timestamp, and metadata
    /// for a single point in a track.
    ///
    /// - important: Supported format: TRACK
    public var points: [Point]?
}
