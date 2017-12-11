//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

import AEXML

private extension String {
    #if swift(>=4.0)
        var characterCount: Int {
            return count
        }
    #else
        var characterCount: Int {
            return count
        }
#endif
}

/// The type of track is defined by this enum value.
public enum TrackType: String {
    /// A GPX formatted track.
    case gpx

    /// A LOC formatted track.
    case loc

    /// A NMEA formatted track.
    case nmea

    /// A TCX formatted track.
    case tcx
    
    /// A custom json formatted track.
    case track

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

    func parse(data: Data) throws -> File {
        switch self {
        case .gpx:
            let document = try parseXML(data: data)
            return try File(gpx: document.root)
        case .loc:
            let document = try parseXML(data: data)
            return try File(loc: document.root)
        case .nmea:
            let rawData = try parseCSV(data: data)
            return try File(nmea: rawData)
        case .tcx:
            let document = try parseXML(data: data)
            return try File(tcx: document.root)
        case .track:
            return try File(track: data)
        }
    }

    private func parseXML(data: Data) throws -> AEXMLDocument {
        guard let document = try? AEXMLDocument(xml: data) else {
            throw TrackParseError.invalidFormat
        }
        return document
    }

    private func parseCSV(data: Data) throws -> [[String]] {
        guard
            let rawString = String(data: data, encoding: .utf8),
            rawString.characterCount > 0 else {
            throw TrackParseError.invalidData
        }

        var result: [[String]] = []
        let rows = rawString.csvEscaped.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
}
