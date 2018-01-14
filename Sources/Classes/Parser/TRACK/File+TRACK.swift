//
//  TRACKParser.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 10/12/2017.
//

extension File {
    
    // MARK: - Init
    
    convenience init(track data: Data) throws {
        // Fetch the type version.
        let version = try TrackTypeVersion(type: .track, version: "1.0")
        self.init(type: .track, version: version)
        
        let decoder = JSONDecoder()
        locations = try? decoder.decode([Point].self, from: data)
    }
    
}
