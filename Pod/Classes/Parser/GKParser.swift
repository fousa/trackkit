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
        
        // Parse the author.
        author = GKPerson(fromElement: metadata["author"])
        
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
        
        // Parse the metadata bounds.
        bounds = GKBounds(fromElement: metadata["bounds"])
    }
    
}

extension GKPerson {
    
    init?(fromElement element: AEXMLElement) {
        // When the element is an error, don't create the link instance.
        guard !element.isError else { return nil }
        
        name = element["name"].optionalValue
        email = ""
        email = String(fromEmailElement: element["email"])
        link = GKLink(fromElement: element["link"])
    }
    
}

extension String {
    
    init?(fromEmailElement element: AEXMLElement) {
        guard let id = element.attributes["id"], let domain = element.attributes["domain"] else {
            return nil
        }
        
        self = "\(id)@\(domain)"
    }
    
}

extension GKBounds {
    
    init?(fromElement element: AEXMLElement) {
        // When the element misses some coordinate data, don't create the link instance.
        guard let minimumLatitude = element.attributes["minlat"], let minimumLongitude = element.attributes["minlon"], let maximumLatitude = element.attributes["maxlat"], let maximumLongitude = element.attributes["maxlon"] else {
            return nil
        }
        
        minimumCoordinate = CLLocationCoordinate2DMake(Double(minimumLatitude)!, Double(minimumLongitude)!)
        maximumCoordinate = CLLocationCoordinate2DMake(Double(maximumLatitude)!, Double(maximumLongitude)!)
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