//
//  String+Range.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 05/06/2017.
//
//

import Foundation

extension String {

    subscript (r: Range<Int>) -> String? {
        guard
            let start = index(startIndex, offsetBy: r.lowerBound, limitedBy: endIndex),
            let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound, limitedBy: endIndex) else {
                return nil
        }

        return self[Range(start ..< end)]
    }

}
