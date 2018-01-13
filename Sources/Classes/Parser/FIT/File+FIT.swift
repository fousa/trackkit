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
        
        let reader = FitReader(data: data)
        reader?.read()
        
        if let records = reader?.records, records.count > 0 {
            let activity = Activity()
            let lap = Lap()
            
            lap.points = records.flatMap {
                let point = Point()
                if let record = $0 as? FitRecord {
                    point.coordinate = record.coordinate
                }
                return point
            }
            
            activity.laps = [lap]
            activities = [activity]
        }
    }
    
}
