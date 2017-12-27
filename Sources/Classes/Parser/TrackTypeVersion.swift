//
//  TrackTypeVersion.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//
//

import Foundation

/// Returns the version of the file type.
public enum TrackTypeVersion {
    /// A GPX formatted track with it's version.
    case gpx(String)

    /// A LOC formatted track with it's version.
    case loc(String)

    /// A NMEA formatted track.
    case nmea(String)

    /// A TCX formatted track with it's version.
    case tcx(String)
    
    /// A TRACK formatted track with it's version.
    case track(String)

    // MARK: - Init

    /// Initialize the TrackTypeVersion by passing the file type and the version string.
    ///
    /// - parameter: the file type
    /// - parameter: the version string
    public init(type: TrackType, version: String?) throws {
        guard
            let version = version,
            TrackTypeVersion.validate(type: type, version: version) else {
            throw TrackParseError.invalidVersion
        }

        switch type {
        case .gpx:
            self = .gpx(version)
        case .loc:
            self = .loc(version)
        case .nmea:
            self = .nmea(version)
        case .tcx:
            self = .tcx(version)
        case .track:
            self = .track(version)
        }
    }

    // MARK: - Version

    /// Return the version string for the file type.
    public var versionString: String? {
        switch self {
        case .gpx(let version):
            return version
        case .loc(let version):
            return version
        case .nmea(let version):
            return version
        case .tcx(let version):
            return version
        case .track(let version):
            return version
        }
    }

    // MARK: - Validation

    private static func validate(type: TrackType, version: String) -> Bool {
        var supportedVersions = [String]()
        switch type {
        case .gpx:
            supportedVersions = ["1.0", "1.1"]
        case .loc:
            supportedVersions = ["1.0"]
        case .nmea:
            supportedVersions = ["NMEA-0183"]
        case .tcx:
            supportedVersions = ["http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2"]
        case .track:
            supportedVersions = ["1.0"]
        }
        return supportedVersions.index(of: version) != nil
    }

}
