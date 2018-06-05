//
//  ImprovedParser.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 02/06/2018.
//

import Foundation
import AEXML

public enum ImprovedParserError: Error {
    case noData
    case noLocationData
    case invalidFormat
    case invalidVersion
    case unknownFileType
}

public class ImprovedParser {
    private let fileType: ImprovedFileType
    private let data: Data
    
    /// Initialize the parser with a data object and extension.
    public init(data: Data?, fileExtension: String) throws {
        guard let data = data else { throw ImprovedParserError.noData }
        fileType = try ImprovedFileType(fileExtension: fileExtension)
        self.data = data
    }
    
    /// Initialize the parser with a file url.
    public init(fileURL: URL) throws {
        fileType = try ImprovedFileType(fileExtension: fileURL.pathExtension)
        data = try Data(contentsOf: fileURL)
    }
    
    /// Parse the file.
    public func parse() throws -> ImprovedFile {
        switch fileType {
        case .gpx: return try ImprovedFile(gpx: data)
        default: throw ImprovedParserError.invalidFormat
        }
    }
}
