//
//  Course+FIT.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 14/01/2018.
//

import Fit

extension Course {
    
    // MARK: - Init
    
    convenience init(fit course: FITCourse?) {
        self.init()
        
        points = course?.points.flatMap { Point(fit: $0) }
    }
    
}

