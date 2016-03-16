//
//  GKParser.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 16/03/16.
//
//

import Foundation

public enum GKParseError: ErrorType {
    case InvalidData
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
    
}