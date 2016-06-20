//
//  GKRoute.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

import Foundation
import AEXML

/**
 An ordered list of waypoints representing a series of turn points leading to a destination.
*/
public final class Route {
    /// GPS name of route.
    public var name: String?

    /// GPS comment for route.
    public var comment: String?

    /// Text description of route for user. Not sent to GPS.
    public var description: String?

    /// Source of data. Included to give user some idea of reliability and accuracy of data.
    public var source: String?

    /// Links to external information about the route.
    public var link: Link?

    /// GPS route number.
    public var number: Int?

    /// Type (classification) of route.
    public var type: String?

    /// A list of route points.
    public var points: [Point]?
}

extension Route: Mappable {
    
    convenience init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }
        
        // When there are not route points, don't create the instance.
        var routePoints: [Point]? = nil
        routePoints <~ element["rtept"].all
        if routePoints == nil {
            return nil
        }
        
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