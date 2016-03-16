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
    
    public func parse() throws {
        guard let document = try? AEXMLDocument(xmlData: data) else {
            throw GKParseError.InvalidFormat
        }

        print(document)
    }
    
}