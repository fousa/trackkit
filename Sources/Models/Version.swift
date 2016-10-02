//
//  Version.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 02/10/2016.
//
//

import AEXML

/// Version information for an application that generated the track file. _TCX only_
public final class Version {
    /// Version number.
    public var versionNumber: String?

    /// Build number.
    public var buildNumber: String?
}
