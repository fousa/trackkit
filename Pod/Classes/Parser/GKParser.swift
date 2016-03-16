//
//  GKParser.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML

public enum GKParseError: ErrorType {
    case InvalidData
    case InvalidFormat
    case Empty
}

public struct GKParser {
    
    // MARK: - Properties
    
    private let data: NSData
    
    // MARK: - Initialization
    
    public init(data: NSData?) throws {
        guard let data = data else {
            throw GKParseError.InvalidData
        }
        
        self.data = data
    }
    
    // MARK: - Parsing
    
    public func parse() throws -> GKFile {
        guard let document = try? AEXMLDocument(xmlData: data) else {
            throw GKParseError.InvalidFormat
        }
        
        var file = GKFile()
        file.appendMetadata(fromDocument: document)

        return file
    }
    
}

extension GKFile {
    
    private mutating func appendMetadata(fromDocument document: AEXMLDocument) {
        // Fetch the creator from the root element.
        creator = document.root.attributes["creator"]
        
        // Fetch the metadata from the metadata element.
        let metadata = document.root["metadata"]
        name = metadata["name"].value
        description = metadata["desc"].value
        author = metadata["author"].value
    }
    
}