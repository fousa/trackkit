//
//  GKTrack.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation

public struct GKTrack {
    public var name: String?
    public var comment: String?
    public var description: String?
    public var source: String?
    public var type: String?
    
    public var number: Int?
    
    public var link: GKLink?
    
    public var segments: [GKTrackSegment]?
}