//
//  GKParser.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation
import AEXML
import AFDateHelper

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
        if isError {
            return nil
        }
        return value
    }
    
    var optionalIntValue: Int? {
        if isError {
            return nil
        }
        return intValue
    }
    
    var isError: Bool {
        return name == AEXMLElement.errorElementName
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
     
        // Parse the time.
        if let timeString = metadata["time"].optionalValue {
            time = NSDate(fromString: timeString, format: .ISO8601(nil))
        }
        
        // Parse the keywords.
        if let keywordsString = metadata["keywords"].optionalValue {
            keywords = keywordsString.componentsSeparatedByString(",").map {
                $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            }
        }
    }
    
}

extension GKLink {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the link instance.
        guard !element.isError else { return nil }
        
        mimeType = element["type"].optionalValue
        text = element["text"].optionalValue
        link = element.attributes["href"]
    }
    
}

extension GKCopyrightNotice {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the copyright instance.
        guard !element.isError else { return nil }
        
        year = element["year"].optionalIntValue
        license = element["license"].optionalValue
        author = element.attributes["author"]
    }
    
}