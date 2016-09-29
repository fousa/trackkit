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
}
