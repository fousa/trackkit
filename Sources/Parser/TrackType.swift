//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

public enum TrackType {
    case gpx
    
    func parse(document: AEXMLDocument) throws -> File {
        switch self {
        case .gpx:
            return try File(gpx: document.root)
        }
    }
}
