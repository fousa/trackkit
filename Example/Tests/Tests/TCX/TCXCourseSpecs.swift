//
//  TCXcourseSpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 02/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class TCXCourseSpec: QuickSpec {
    override func spec() {
        describe("courses") {
            it("should not have courses") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'></TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .tcx).parse()

                expect(file.courses).to(beNil())
            }

            it("should not have courses without points") {
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

                expect(file.courses?.count).to(beNil())
            }

            describe("course data") {
                var course: Course!

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

                    course = file.courses?.first!
                }

                it("should have a name") {
                    expect(course.name) == "Jelle Vandebeeck"
                }

                it("should have a lap with total time in seconds") {
                    expect(course.totalTime) == 123
                }

                it("should have a lap with total distance in meters") {
                    expect(course.totalDistance) == 456
                }

                it("should have a lap with a begin position") {
                    expect(course.beginPosition?.latitude) == 51.208845321089
                    expect(course.beginPosition?.longitude) == 4.394159177318
                }

                it("should have a lap with an end position") {
                    expect(course.endPosition?.latitude) == 51.208867281675
                    expect(course.endPosition?.longitude) == 4.394087595865
                }

                it("should have a lap with an intensity") {
                    expect(course.intensity) == .active
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

                    point = file.courses?.first?.points?.first!
                }

                it("should have a track point time") {
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

            describe("empty course point") {
                var point: Point!

                beforeEach {
                    let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                    + "<Courses>"
                                        + "<Course>"
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

                    point = file.courses?.first?.points?.first!
                }



                it("should not have a track point time") {
                    expect(point.time?.description).to(beNil())
                }

                it("should not have a altitude in meters") {
                    expect(point.elevation).to(beNil())
                }

                it("should not have a distance in meters") {
                    expect(point.distance).to(beNil())
                }
            }
        }
    }
}
