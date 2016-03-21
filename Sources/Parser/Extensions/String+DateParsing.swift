//
//  NSDate+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 21/03/16.
//
//

import Foundation

extension String {
    
    func isoDate() -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
        return formatter.dateFromString(self)
    }
    
}