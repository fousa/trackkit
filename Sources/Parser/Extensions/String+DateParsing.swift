//
//  NSDate+Parsing.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 21/03/16.
//
//

import Foundation

extension String {

    func isoDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.date(from: self)
    }

}
