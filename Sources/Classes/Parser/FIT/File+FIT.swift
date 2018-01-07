//
//  FITParser.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 10/12/2017.
//

extension File {
    
    // MARK: - Init
    
    convenience init(fit data: Data) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .fit, version: "1.0")
        self.init(type: .fit, version: version)
    }
    
}
