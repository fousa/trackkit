//
//  Lap+FIT.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//

import Fit

extension Lap {
    
    // MARK: - Init
    
    convenience init(fit lap: FITLap?) {
        self.init()
        
        startTime = lap?.startTime
        totalTime = lap?.totalTime?.doubleValue
        totalDistance = lap?.totalDistance?.doubleValue
        maximumSpeed = lap?.maximumSpeed?.doubleValue
        calories = lap?.totalCalories?.intValue
        averageHeartRate = lap?.averageHeartRate?.intValue
        maximumHeartRate = lap?.maximumHeartRate?.intValue
        cadence = lap?.averageCadence?.intValue
        points = lap?.points.compactMap { Point(fit: $0) }
    }
    
}
