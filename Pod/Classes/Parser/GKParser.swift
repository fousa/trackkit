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

extension AEXMLElement {
    
    var optionalValue: String? {
        if name == AEXMLElement.errorElementName {
            return nil
        }
        return value
    }
    
}

extension GKFile {
    
    private mutating func appendMetadata(fromDocument document: AEXMLDocument) {
        // Fetch the creator from the root element.
        creator = document.root.attributes["creator"]
        
        // Fetch the metadata from the metadata element.
        let metadata = document.root["metadata"]
        name = metadata["name"].optionalValue
        description = metadata["desc"].optionalValue
        author = metadata["author"].optionalValue
        
        // Parse the metadata copyright notice.
        copyrightNotice = GKCopyrightNotice(fromElement: metadata["copyright"])
        
        // Parse the metadata link.
        link = GKLink(fromElement: metadata["link"])
    }
    
}

extension GKLink {
    
    init?(fromElement element: AEXMLElement?) {
        guard let element = element else {
            return nil
        }
        
        mimeType = element["type"].optionalValue
        text = element["text"].optionalValue
        link = element.attributes["href"]
    }
    
}

extension GKCopyrightNotice {
    
    init?(fromElement element: AEXMLElement?) {
        guard let element = element else {
            return nil
        }
        
        year = element["year"].intValue
        license = element["license"].optionalValue
        author = element.attributes["author"]
    }
    
}