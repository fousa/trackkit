//
//  String+CSV.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/06/2017.
//
//

import Foundation

extension String {

    var csvEscaped: String {
        return replacingOccurrences(of: "\r", with: "\n").replacingOccurrences(of: "\n\n", with: "\n")
    }

}
