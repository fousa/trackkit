//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

public enum TrackType: String {
    case gpx
    
    // MARK: - Init
    
    public init?(fileExtension: String) {
        guard let value = TrackType(rawValue: fileExtension.lowercased()) else {
            return nil
        }
        self = value
    }
    
    // MARK: - Parsing
    
    func parse(document: AEXMLDocument) throws -> File {
        switch self {
        case .gpx:
            return try File(gpx: document.root)
        }
    }
}
