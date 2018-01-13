//
//  Activity+FIT.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//

import Fit

extension Activity {
    
    // MARK: - Init
    
    convenience init(fit activity: FITActivity?) {
        self.init()
        
        laps = activity?.laps?.flatMap { Lap(fit: $0) }
    }
    
}
