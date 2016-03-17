//
//  GKFile.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation

public struct GKFile {
    public var creator: String?
    public var name: String?
    public var description: String?
    public var author: String?
    public var copyrightNotice: GKCopyrightNotice?
    
    public var time: NSDate?
    
    public var link: GKLink?
    
    public var keywords: [String]?
    public var bounds: GKBounds?
    public var waypoints: [GKPoint]?
    public var routes: [GKRoute]?
    public var tracks: [GKTrack]?
}