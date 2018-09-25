//
//  String+Range.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 05/06/2017.
//
//

import Foundation

extension String {

    // swiftlint:disable identifier_name
    subscript (r: Range<Int>) -> String? {
        guard
            let start = index(startIndex, offsetBy: r.lowerBound, limitedBy: endIndex),
            // swiftlint:disable identifier_name
            let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound, limitedBy: endIndex) else {
            return nil
        }
        
        let range = start..<end
        return String(self[range])
    }

}
