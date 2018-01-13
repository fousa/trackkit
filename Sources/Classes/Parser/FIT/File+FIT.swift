//
//  FITParser.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 10/12/2017.
//

import Fit

extension File {
    
    // MARK: - Init
    
    convenience init(fit file: FITFile) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .fit, version: "1.0")
        self.init(type: .fit, version: version)
        
        activities = file.activities.flatMap { Activity(fit: $0) }
    }
    
}
