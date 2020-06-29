//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//

import Quick
import Nimble
import Foundation
import TrackKit

class GPXCommonSpec: QuickSpec {
    override func spec() {
        var file: File!

        describe("common data") {
            beforeEach {
                let content = "<gpx creator='TrackKit' version='1.1'>"
                                + "<metadata>"
                                    + "<name>Jelle</name>"
                                    + "<desc>A GPX file</desc>"
                                    + "<time>2016-03-10T10:05:12+02:00</time>"
                                    + "<keywords>hiking, forest, wild</keywords>"

                                    // Author
                                    + "<author>"
                                        + "<name>Jelle Vandebeeck</name>"
                                        + "<email id='jelle' domain='vandebeeck.be' />"
                                        + "<link href='http://fousa.be'>"
                                            + "<text>Fousa</text>"
                                            + "<type>text/html</type>"
                                        + "</link>"
                                    + "</author>"

                                    // Copyright
                                    + "<copyright author='Jelle Vandebeeck'>"
                                        + "<year>2016</year>"
                                        + "<license>http://fousa.be/license.html</license>"
                                    + "</copyright>"

                                    // Link
                                    + "<link href='http://fousa.be'>"
                                        + "<text>Fousa</text>"
                                        + "<type>text/html</type>"
                                    + "</link>"

                                    // Bounds
                                    + "<bounds minlat='42.1' minlon='-71.9' maxlat='42.4' maxlon='-71.1' />"
                                + "</metadata>"
                            + "</gpx>"
                let data = content.data(using: .utf8)
                file = try! TrackParser(data: data, type: .gpx).parse()
            }

            it("should have a creator name") {
                expect(file.creator) == "TrackKit"
            }

            context("metadata") {
                it("should have a name") {
                    expect(file.name) == "Jelle"
                }

                it("should have a description") {
                    expect(file.description) == "A GPX file"
                }

                it("should have a author") {
                    expect(file.author?.name) == "Jelle Vandebeeck"
                    expect(file.author?.email) == "jelle@vandebeeck.be"
                    expect(file.author?.link?.link) == "http://fousa.be"
                    expect(file.author?.link?.text) == "Fousa"
                    expect(file.author?.link?.mimeType) == "text/html"
                }

                it("should have a copyright notice") {
                    expect(file.copyrightNotice?.author) == "Jelle Vandebeeck"
                    expect(file.copyrightNotice?.year) == 2016
                    expect(file.copyrightNotice?.license) == URL(string: "http://fousa.be/license.html")
                }

                it("should have a link") {
                    expect(file.link?.link) == "http://fousa.be"
                    expect(file.link?.text) == "Fousa"
                    expect(file.link?.mimeType) == "text/html"
                }

                it("should have a time") {
                    expect(file.time?.description) == "2016-03-10 08:05:12 +0000"
                }

                it("should have keywords") {
                    expect(file.keywords) == ["hiking", "forest", "wild"]
                }

                it("should have bounds") {
                    expect(file.bounds?.minimumCoordinate?.latitude) == 42.1
                    expect(file.bounds?.minimumCoordinate?.longitude) == -71.9
                    expect(file.bounds?.maximumCoordinate?.latitude) == 42.4
                    expect(file.bounds?.maximumCoordinate?.longitude) == -71.1
                }
            }

            describe("email data") {
                beforeEach {
                    let content = "<gpx creator='TrackKit' version='1.1'>"
                                    + "<metadata>"
                                        + "<author>"
                                            + "<email id='jelle' />"
                                        + "</author>"
                                    + "</metadata>"
                                + "</gpx>"
                    let data = content.data(using: .utf8)
                    file = try! TrackParser(data: data, type: .gpx).parse()
                }

                context("metadata") {
                    it("should not have an email") {
                        expect(file.author?.email).to(beNil())
                    }
                }
            }

            context("empty file") {
                beforeEach {
                    let content = "<gpx version='1.1'></gpx>"
                    let data = content.data(using: .utf8)
                    file = try! TrackParser(data: data, type: .gpx).parse()
                }

                it("should not have a creator name") {
                    expect(file.creator).to(beNil())
                }

                context("metadata") {
                    it("should not have a name") {
                        expect(file.name).to(beNil())
                    }

                    it("should not have a description") {
                        expect(file.description).to(beNil())
                    }

                    it("should not have a author") {
                        expect(file.author).to(beNil())
                    }

                    it("should not have a copyright notice") {
                        expect(file.copyrightNotice).to(beNil())
                        expect(file.copyrightNotice?.author).to(beNil())
                        expect(file.copyrightNotice?.year).to(beNil())
                        expect(file.copyrightNotice?.license).to(beNil())
                    }

                    it("should not have a link") {
                        expect(file.link).to(beNil())
                        expect(file.link?.link).to(beNil())
                        expect(file.link?.text).to(beNil())
                        expect(file.link?.mimeType).to(beNil())
                    }

                    it("should not have a time") {
                        expect(file.time).to(beNil())
                    }

                    it("should not have keywords") {
                        expect(file.keywords).to(beNil())
                    }

                    it("should not have bounds") {
                        expect(file.bounds).to(beNil())
                    }
                }
            }
        }
    }
}
