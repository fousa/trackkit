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

/**
 The parser that is responsible for converting a given `Data` representation of
 the GPX file into an understandable format.
 */
public struct TrackParser {
    
    // MARK: - Properties
    
    fileprivate let data: Data
    fileprivate let type: TrackType
    
    // MARK: - Initialization
    
    /**
     Initialize the parsed with a data instance.
     
     - Parameter data: The GPX data object you want to parse.
     
     - Throws: `ParseError.invalidData` if the data object is empty.
     */
    public init(data: Data?, type: TrackType) throws {
        guard let data = data else {
            throw ParseError.invalidData
        }
        
        self.type = type
        self.data = data
    }
    
    /**
     Parse the data _passed through the initializer_ into a representable
     format.
     
     - Throws: `ParseError.invalidFormat` if the data cannot be parsed.
     - Throws: `ParseError.invalidVersion` if the versio is incorrect.
     
     - Returns: A parsed `File` object.
     */
    public func parse() throws -> File {
        guard let document = try? AEXMLDocument(xml: data) else {
            throw ParseError.invalidFormat
        }
        
        return try type.parse(document: document)
    }
}
