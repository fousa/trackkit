//
//  Operators.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

/**
 The parsable can be responsible for converting a given `Data` representation of
 the file into an understandable format.
 */
protocol Parsable {
    /**
     Initialize the parsed with a data instance.
     
     - Parameter data: The GPX data object you want to parse.
     
     - Throws: `ParseError.invalidData` if the data object is empty.
     */
    init(data: Data?) throws
    
    /**
     Parse the data _passed through the initializer_ into a representable
     format.
     
     - Throws: `ParseError.invalidFormat` if the data cannot be parsed.
     - Throws: `ParseError.invalidVersion` if the versio is incorrect.
     
     - Returns: A parsed `File` object.
     */
    func parse() throws -> File
}
