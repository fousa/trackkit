//
//  Gpxable.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//
//

import AEXML

protocol TCXable {
    init?(tcx element: AEXMLElement)
}
