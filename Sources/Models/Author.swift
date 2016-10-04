//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//

/// The application that was responsible for generating the file.
///
/// - important: Supported format: TCX
public final class Author {
    /// Name of the author application.
    public var name: String?

    /// Version of the application.
    public var version: Version?

    /// The language of the file.
    public var language: String?

    /// The Garmin part number of the application.
    public var partNumber: String?
}
