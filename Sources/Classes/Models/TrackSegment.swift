//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 16/03/16.
//

import Foundation

/// A Track Segment holds a list of Track Points which are logically connected in
/// order. To represent a single GPS track where GPS reception was lost, or the GPS
/// receiver was turned off, start a new Track Segment for each continuous span of
/// track data.
///
/// - important: Supported format: GPX
public final class TrackSegment {
    /// A Track Point holds the coordinates, elevation, timestamp, and metadata
    /// for a single point in a track.
    public var points: [Point]?
}
