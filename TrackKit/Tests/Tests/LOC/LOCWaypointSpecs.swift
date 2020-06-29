//
//  LOCWaypointSpecs.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class LOCWaypointSpecs: QuickSpec {
    override func spec() {
        describe("waypoints") {
            it("should not have waypoints") {
                let content = "<loc version='1.0'></loc>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .loc).parse()

                expect(file.waypoints).to(beNil())
            }

            it("should not have waypoints without a coordinate") {
                let content = "<loc version='1.0'>"
                                + "<waypoint></waypoint>"
                            + "</loc>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .loc).parse()

                expect(file.waypoints).to(beNil())
            }

            it("should have waypoints") {
                let content = "<loc version='1.0'>"
                                + "<waypoint>"
                                    + "<coord lat='51.16215' lon='4.456933'/>"
                                + "</waypoint>"
                            + "</loc>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .loc).parse()

                expect(file.waypoints?.count) == 1
            }
        }

        describe("waypoint data") {
            var point: Point!

            beforeEach {
                let content = "<loc version='1.0'>"
                                + "<waypoint>"
                                    + "<name id='GC54AMF'><![CDATA[Mortsel]]></name>"
                                    + "<coord lat='51.16215' lon='4.456933'/>"
                                    + "<type>Geocache</type>"
                                    + "<link text='Details'>http://www.geocaching.com</link>"
                                + "</waypoint>"
                            + "</loc>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .loc).parse()

                point = file.waypoints?.first!
            }

            it("should have a coordinate") {
                expect(point.coordinate?.latitude) == 51.16215
                expect(point.coordinate?.longitude) == 4.456933
            }

            it("should have a name") {
                expect(point.name) == "GC54AMF"
            }

            it("should have a description") {
                expect(point.description) == "Mortsel"
            }

            it("should have a link") {
                expect(point.link?.link) == "http://www.geocaching.com"
                expect(point.link?.text) == "Details"
            }

            it("should have a type") {
                expect(point.type) == "Geocache"
            }
        }

        describe("empty waypoint") {
            var point: Point!

            beforeEach {
                let content = "<loc version='1.0'>"
                                + "<waypoint>"
                                    + "<coord lat='51.16215' lon='4.456933'/>"
                                + "</waypoint>"
                            + "</loc>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .loc).parse()

                point = file.waypoints?.first!
            }

            it("should not have a name") {
                expect(point.name).to(beNil())
            }

            it("should not have a description") {
                expect(point.description).to(beNil())
            }

            it("should not have a link") {
                expect(point.link).to(beNil())
            }

            it("should not have a type") {
                expect(point.type).to(beNil())
            }
        }
    }
}
