//
//  Author.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//
//

/**
 A person or organization.
 */
public final class Author {
    /// Name of person or organization.
    public var name: String?

    /// Version of the application.
    public var version: Version?

    /// The language of the file. _TCX only_
    public var language: String?

    /// The Garmin part number of the application. _TCX only_
    public var partNumber: String?
}
