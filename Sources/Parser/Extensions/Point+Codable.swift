//
//  Point+Codable.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 10/12/2017.
//

import CoreLocation

extension Point {
    
    // MARK: - Coding
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case horizontalAccuracy
        case verticalAccuracy
        case course
        case speed
        case timestamp
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(coordinate?.latitude, forKey: .latitude)
        try container.encode(coordinate?.longitude, forKey: .longitude)
        try container.encode(elevation, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .horizontalAccuracy)
        try container.encode(verticalAccuracy, forKey: .verticalAccuracy)
        try container.encode(course, forKey: .course)
        try container.encode(speed, forKey: .speed)
        try container.encode(time, forKey: .timestamp)
    }
    
}
