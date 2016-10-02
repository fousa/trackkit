//
//  Gpxable.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//
//

import AEXML

protocol TCXable: Parsable {
    init?(tcx element: AEXMLElement)
}
