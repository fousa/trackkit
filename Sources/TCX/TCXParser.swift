//
//  Parser.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import CoreLocation
import AEXML

/**
 The parser that is responsible for converting a given `Data` representation of
 the GPX file into an understandable format.
*/
public struct TCXParser: Parsable {

    // MARK: - Properties

    fileprivate let data: Data

    // MARK: - Initialization

    /**
        Initialize the parsed with a data instance.

        - Parameter data: The GPX data object you want to parse.

        - Throws: `ParseError.invalidData` if the data object is empty.
    */
    public init(data: Data?) throws {
        guard let data = data else {
            throw ParseError.invalidData
        }

        self.data = data
    }

    // MARK: - Parsing

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

        guard let file = File(fromElement: document.root) else {
            throw ParseError.invalidVersion
        }

        return file
    }

}
