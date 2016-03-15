//
//  GKRoute.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation

struct GKRoute {
    var name: String?
    var comment: String?
    var description: String?
    var source: String?
    var type: String?
    
    var number: Int?
    
    var link: GKLink?
    
    var points: [GKPoint]?
}