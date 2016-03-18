//
//  GKTrack.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML

public final class GKTrack {
    public var name: String?
    public var comment: String?
    public var description: String?
    public var source: String?
    public var type: String?
    
    public var number: Int?
    
    public var link: GKLink?
    
    public var segments: [GKTrackSegment]?
}

extension GKTrack: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        
        // When there are not route points, don't create the instance.
        var routeSegments: [GKTrackSegment]? = nil
        routeSegments <~ element["trkseg"].all
        if routeSegments == nil { return nil }
        
        self.init()
        
        name        <~ element["name"]
        comment     <~ element["cmt"]
        description <~ element["desc"]
        source      <~ element["src"]
        number      <~ element["number"]
        type        <~ element["type"]
        link        <~ element["link"]
        segments    = routeSegments
    }
    
}