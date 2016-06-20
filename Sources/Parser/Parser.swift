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

/**
 A list of errors that can be thrown by the parser. These errors can be thrown during initialization or during the parsing process.
 
 - invalidData: When the data object is empty.
 - invalidFormat: When the data contains an incorrect format that can't be parsed.
 - invalidVersion: When the version of the file is invalid.
*/
public enum ParseError: ErrorType {
    /// Thrown when the data object is empty.
    case invalidData
    /// Thrown when the data contains an incorrect format that can't be parsed.
    case invalidFormat
    /// Thrown when the data contains an incorrect version that can't be parsed. Currently only version 1.1 is supported.
    case invalidVersion
}

/**
 The parser that is responsible for converting a given `NSData` representation of the GPX file
 into an understandable format.
*/
public struct Parser {
    
    // MARK: - Properties
    
    private let data: NSData
    
    // MARK: - Initialization

    /**
        Initialize the parsed with a data instance.

        - Parameter data: The GPX data object you want to parse.
        
        - Throws: `GKParseError.invalidData` if the data object is empty.
    */
    public init(data: NSData?) throws { // tailor:disable
        guard let data = data else {
            throw ParseError.invalidData
        }
        
        self.data = data
    }
    
    // MARK: - Parsing

    /**
        Parse the data _passed through the initializer_ into a representable
        format.
    
         - Throws: `GKParseError.invalidFormat` if the data cannot be parsed.
         - Throws: `GKParseError.invalidVersion` if the versio is incorrect.
    
        - Returns: A parsed `GKFile` object.
    */
    public func parse() throws -> File {
        guard let document = try? AEXMLDocument(xmlData: data) else {
            throw ParseError.invalidFormat
        }
        
        guard let file = File(fromElement: document.root) else {
            throw ParseError.invalidVersion
        }
        
        return file
    }
    
}