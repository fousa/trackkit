//
//  TCXRouteSpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 02/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class TCXRouteSpec: QuickSpec {
    override func spec() {
        describe("routes") {
            it("should not have routes") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'></TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .tcx).parse()

                expect(file.routes).to(beNil())
            }

            it("should not have routes without points") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                + "<Courses>"
                                    + "<Course>"
                                        + "<Track>"
                                        + "</Track>"
                                    + "</Course>"
                                + "</Courses>"
                            + "</TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .tcx).parse()

                expect(file.routes?.count).to(beNil())
            }

            describe("route data") {
                var route: Route!

                beforeEach {
                    beforeEach {
                        let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                        + "<Courses>"
                                            + "<Course>"
                                                + "<Name>Jelle Vandebeeck</Name>"
                                                + "<Lap>"
                                                    + "<TotalTimeSeconds>123</TotalTimeSeconds>"
                                                    + "<DistanceMeters>456</DistanceMeters>"
                                                    + "<BeginPosition>"
                                                        + "<LatitudeDegrees>51.208845321089</LatitudeDegrees>"
                                                        + "<LongitudeDegrees>4.394159177318</LongitudeDegrees>"
                                                    + "</BeginPosition>"
                                                    + "<EndPosition>"
                                                        + "<LatitudeDegrees>51.208867281675</LatitudeDegrees>"
                                                        + "<LongitudeDegrees>4.394087595865</LongitudeDegrees>"
                                                    + "</EndPosition>"
                                                    + "<Intensity>Active</Intensity>"
                                                + "</Lap>"
                                                + "<Track>"
                                                    + "<TrackPoint>"
                                                        + "<Position>"
                                                            + "<LatitudeDegrees>51.208845321089</LatitudeDegrees>"
                                                            + "<LongitudeDegrees>4.394159177318</LongitudeDegrees>"
                                                        + "</Position>"
                                                    + "</TrackPoint>"
                                                + "</Track>"
                                            + "</Course>"
                                        + "</Courses>"
                                    + "</TrainingCenterDatabase>"
                        let data = content.data(using: .utf8)
                        let file = try! TrackParser(data: data, type: .tcx).parse()

                        route = file.routes?.first!
                    }
                }

                it("should have a name") {
                    expect(route.name) == "Jelle Vandebeeck"
                }

                it("should have a lap") {
                    expect(route.lap).toNot(beNil())
                }

                it("should have a lap with total time in seconds") {
                    expect(route.lap?.totalTime) == 456
                }

                it("should have a lap with total distance in meters") {
                    expect(route.lap?.totalDistance) == 456
                }

                it("should have a lap with a begin position") {
                    expect(route.lap?.beginPosition?.latitude) == 51.208845321089
                    expect(route.lap?.beginPosition?.longitude) == 4.394159177318
                }

                it("should have a lap with an end position") {
                    expect(route.lap?.endPosition?.latitude) == 51.208867281675
                    expect(route.lap?.endPosition?.longitude) == 4.394087595865
                }

                it("should have a lap with an intensity") {
                    expect(route.lap?.intensity) == .active
                }
            }

            describe("course track point data") {
                var point: Point!

                beforeEach {
                    let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                    + "<Courses>"
                                        + "<Course>"
                                            + "<Track>"
                                                + "<TrackPoint>"
                                                    + "<Time>2016-03-10T10:05:12+02:00</Time>"
                                                    + "<Position>"
                                                        + "<LatitudeDegrees>51.208845321089</LatitudeDegrees>"
                                                        + "<LongitudeDegrees>4.394159177318</LongitudeDegrees>"
                                                    + "</Position>"
                                                    + "<AltitudeMeters>100</AltitudeMeters>"
                                                    + "<DistanceMeters>456</DistanceMeters>"
                                                + "</TrackPoint>"
                                            + "</Track>"
                                        + "</Course>"
                                    + "</Courses>"
                                + "</TrainingCenterDatabase>"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .tcx).parse()

                    point = file.routes?.first?.points?.first!
                }

                it("should have a track point") {
                    expect(point.time?.description) == "2016-03-10 08:05:12 +0000"
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 51.208845321089
                    expect(point.coordinate?.longitude) == 4.394159177318
                }

                it("should have a altitude in meters") {
                    expect(point.elevation) == 100
                }

                it("should have a distance in meters") {
                    expect(point.distance) == 456
                }
            }
        }
    }
}
