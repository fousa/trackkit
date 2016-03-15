//
//  GKFile.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation

struct GKFile {
    var creator: String?
    var name: String?
    var description: String?
    var author: String?
    var copyrightNotice: String?
    
    var time: NSDate?
    
    var link: GKLink?
    
    var keyword: [String]?
    var bounds: GKBounds?
    var waypoints: [GKPoint]?
    var routes: [GKRoute]?
    var tracks: [GKTrack]?
}