//
//  ImprovedFileType.swift
//  AEXML
//
//  Created by Jelle Vandebeeck on 02/06/2018.
//

import Foundation

public enum ImprovedFileType: String {
    case gpx
    case tcx
    case fit
    case loc
    case nmea
    case track
    
    // MARK: - Init
    
    /// Initialize the FileType by passing the file extension.
    ///
    /// - parameter: the file extension (case is not important)
    public init(fileExtension: String) throws {
        guard let fileType = ImprovedFileType(rawValue: fileExtension.lowercased()) else {
            throw ImprovedParserError.unknownFileType
        }
        self = fileType
    }
    
    public var supportedVersions: [String] {
        switch self {
        case .gpx: return ["1.0", "1.1"]
        default: return []
        }
    }
    
    public func validate(version: String?) throws {
        if
            let version = version,
            supportedVersions.index(of: version) != nil { return }
        throw ImprovedParserError.invalidVersion
    }
}
