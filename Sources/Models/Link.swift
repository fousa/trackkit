//
//  Link.swift
//  Pods
//
//  Created by Jelle Vandebeeck on 15/03/16.
//
//

/**
 A link to an external resource (Web page, digital photo, video clip, etc)
 with additional information.
*/
public final class Link {
    /// URL of hyperlink.
    public var link: String?

    /// Text of hyperlink.
    public var text: String?

    /// Mime type of content.
    public var mimeType: String?
}
