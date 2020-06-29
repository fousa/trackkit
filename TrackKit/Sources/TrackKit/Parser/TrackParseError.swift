//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

/**
 A list of errors that can be thrown by the parser. These errors can be
 thrown during initialization or during the parsing process.

 - invalidData: When the data object is empty.
 - invalidFormat: When the data contains an incorrect format that can't be parsed.
 - invalidVersion: When the version of the file is invalid.
 */
public enum TrackParseError: Error {
    /// Thrown when the data object is empty.
    case invalidData
    /// Thrown when the data contains an incorrect format that can't be parsed.
    case invalidFormat
    /// Thrown when the data contains an incorrect version that can't be parsed.
    case invalidVersion
}
