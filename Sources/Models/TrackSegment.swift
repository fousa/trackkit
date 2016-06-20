//
//  GKTrackSegment.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML

/**
 A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
 */
public final class TrackSegment {
    /// A Track Point holds the coordinates, elevation, timestamp, and metadata for a single point in a track.
    public var points: [Point]?
}

extension TrackSegment: Mappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        
        // When there are not route points, don't create the instance.
        var trackPoints: [Point]? = nil
        trackPoints <~ element["trkpt"].all
        if trackPoints == nil {
            return nil
        }
        self.init()
        
        points = trackPoints
    }
    
}