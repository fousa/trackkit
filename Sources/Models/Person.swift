//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 18/03/16.
//

/// A person or organization.
///
/// - important: Supported format: GPX
public final class Person {
    /// Name of person or organization.
    public var name: String?

    /// Email address.
    public var email: String?

    /// Link to Web site or other external information about person.
    public var link: Link?
}
