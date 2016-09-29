//
//  Gpxable.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//
//

import AEXML

protocol GPXable {
    init?(gpx element: AEXMLElement)
}
