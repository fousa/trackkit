//
//  GKTrackSegment.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML

public final class GKTrackSegment {
    public var points: [GKPoint]?
}

extension GKTrackSegment: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        
        // When there are not route points, don't create the instance.
        var trackPoints: [GKPoint]? = nil
        trackPoints <~ element["trkpt"].all
        if trackPoints == nil { return nil }
        self.init()
        
        points = trackPoints
    }
    
}