//
//  Route+TCX.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

import AEXML

extension Route: TCXable {

    convenience init?(tcx element: AEXMLElement) {
        // When the element is an error, don't create the instance.
        if let _ = element.error {
            return nil
        }

        // When there are not route points, don't create the instance.
        var routePoints: [Point]? = nil
        routePoints <~ element["Track"]["TrackPoint"].all?.flatMap { Point(tcx: $0) }
        if routePoints == nil {
            return nil
        }

        self.init()

        name   <~ element["Name"]
        lap    <~ Lap(tcx: element["Lap"])
        points = routePoints
    }

}
