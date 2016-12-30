//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

import AEXML

/// The type of track is defined by this enum value.
public enum TrackType: String {
    /// A GPX formatted track.
    case gpx

    /// A LOC formatted track.
    case loc

    /// A TCX formatted track.
    case tcx

    // MARK: - Init

    /// Initialize the TrackType by passing the file extension.
    ///
    /// - parameter: the file extension (case is not important)
    public init?(fileExtension: String) {
        guard let value = TrackType(rawValue: fileExtension.lowercased()) else {
            return nil
        }
        self = value
    }

    // MARK: - Parsing

    func parse(document: AEXMLDocument) throws -> File {
        switch self {
        case .gpx:
            return try File(gpx: document.root)
        case .loc:
            return try File(loc: document.root)
        case .tcx:
            return try File(tcx: document.root)
        }
    }
}
