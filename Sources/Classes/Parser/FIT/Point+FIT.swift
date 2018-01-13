//
//  Point+FIT.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//

import Fit

extension Point {
    
    // MARK: - Init
    
    convenience init(fit point: FITPoint?) {
        self.init()
        
        coordinate = point?.coordinate
        elevation = point?.elevation?.doubleValue
        distance = point?.distance?.doubleValue
        cadence = point?.cadence?.intValue
        heartRate = point?.heartrate?.intValue
        time = point?.time
    }
    
}
