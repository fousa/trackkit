//
//  GKRoute.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import AEXML

public final class GKRoute {
    public var name: String?
    public var comment: String?
    public var description: String?
    public var source: String?
    public var type: String?
    
    public var number: Int?
    
    public var link: GKLink?
    
    public var points: [GKPoint]?
}

extension GKRoute: GKMappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if element.errored { return nil }
        
        // When there are not route points, don't create the instance.
        var routePoints: [GKPoint]? = nil
        routePoints <~ element["rtept"].all
        if routePoints == nil { return nil }
        
        self.init()
        
        name        <~ element["name"]
        comment     <~ element["cmt"]
        description <~ element["desc"]
        source      <~ element["src"]
        number      <~ element["number"]
        type        <~ element["type"]
        link        <~ element["link"]
        points      = routePoints
    }
    
}