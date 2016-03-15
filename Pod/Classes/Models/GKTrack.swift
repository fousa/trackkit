//
//  GKTrack.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation

struct GKTrack {
    var name: String?
    var comment: String?
    var description: String?
    var source: String?
    var type: String?
    
    var number: Int?
    
    var link: GKLink?
    
    var segments: [GKTrackSegment]?
}