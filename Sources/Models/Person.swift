//
//  Person.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 18/03/16.
//
//

import AEXML

/**
 A person or organization.
*/
public final class Person {
    /// Name of person or organization.
    public var name: String?

    /// Email address.
    public var email: String?

    /// Link to Web site or other external information about person.
    public var link: Link?

    /// Application that generated the file build information. _TCX only_
    public var build: Build?

    /// The language of the file. _TCX only_
    public var language: String?

    /// The Garmin part number of the application. _TCX only_
    public var partNumber: String?
}
