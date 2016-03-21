//
//  GKParser.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import CoreLocation
import AEXML
import AFDateHelper

/**
 A list of errors that can be thrown by the parser. These errors can be thrown during initialization or during the parsing process.
 
 - InvalidData: When the data object is empty.
 - InvalidFormat: When the data contains an incorrect format that can't be parsed.
 - Empty: When no routes, tracks or waypoints can be found. _not yet implemented_
*/
public enum GKParseError: ErrorType {
    /// Thrown when the data object is empty.
    case InvalidData
    /// Thrown when the data contains an incorrect format that can't be parsed.
    case InvalidFormat
    /// Thrown when no routes, tracks or waypoints can be found. _not yet implemented_
    case Empty
}

/**
 The parser that is responsible for converting a given `NSData` representation of the GPX file
 into an understandable format.
*/
public struct GKParser {
    
    // MARK: - Properties
    
    private let data: NSData
    
    // MARK: - Initialization

    /**
        Initialize the parsed with a data instance.

        - Parameter data: The GPX data object you want to parse.
        
        - Throws: `GKParseError.InvalidData` if the data object is empty.
    */
    public init(data: NSData?) throws { // tailor:disable
        guard let data = data else {
            throw GKParseError.InvalidData
        }
        
        self.data = data
    }
    
    // MARK: - Parsing

    /**
        Parse the data _passed through the initializer_ into a representable
        format.
    
        - Throws: `GKParseError.InvalidFormat` if the data cannot be parsed.
    
        - Returns: A parsed `GKFile` object.
    */
    public func parse() throws -> GKFile {
        guard let document = try? AEXMLDocument(xmlData: data) else {
            throw GKParseError.InvalidFormat
        }
        
        return GKFile(fromElement: document.root)
    }
    
}