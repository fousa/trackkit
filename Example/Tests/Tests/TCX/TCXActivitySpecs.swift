//
//  TCXActivitySpecs.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 03/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class TCXActivitySpecs: QuickSpec {
    override func spec() {
        describe("activities") {
            it("should not have activities") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'></TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .tcx).parse()

                expect(file.activities).to(beNil())
            }

            it("should not have activities without points") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                + "<Activities>"
                                    + "<Activity>"
                                        + "<Lap>"
                                            + "<Track>"
                                            + "</Track>"
                                        + "</Lap>"
                                    + "</Activity>"
                                + "</Activities>"
                            + "</TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .tcx).parse()

                expect(file.activities?.count).to(beNil())
            }

            describe("activity data") {
                var activity: Activity!

                beforeEach {
                    let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                    + "<Activities>"
                                        + "<Activity Sport='Biking'>"
                                            + "<Id>2016-10-02T09:31:26.000Z</Id>"
                                            + "<Lap StartTime='2016-10-02T09:31:26.000Z'>"
                                                + "<TotalTimeSeconds>123</TotalTimeSeconds>"
                                                + "<DistanceMeters>456</DistanceMeters>"
                                                + "<MaximumSpeed>17</MaximumSpeed>"
                                                + "<Calories>1007</Calories>"
                                                + "<AverageHeartRateBpm>"
                                                    + "<Value>155</Value>"
                                                + "</AverageHeartRateBpm>"
                                                + "<MaximumHeartRateBpm>"
                                                    + "<Value>175</Value>"
                                                + "</MaximumHeartRateBpm>"
                                                + "<Intensity>Active</Intensity>"
                                                + "<Cadence>77</Cadence>"
                                                + "<TriggerMethod>Manual</TriggerMethod>"
                                                + "<Track>"
                                                    + "<Trackpoint>"
                                                        + "<Position>"
                                                            + "<LatitudeDegrees>51.208845321089</LatitudeDegrees>"
                                                            + "<LongitudeDegrees>4.394159177318</LongitudeDegrees>"
                                                        + "</Position>"
                                                    + "</Trackpoint>"
                                                + "</Track>"
                                            + "</Lap>"
                                        + "</Activity>"
                                    + "</Activities>"
                                + "</TrainingCenterDatabase>"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .tcx).parse()

                    activity = file.activities?.first!
                }

                it("should have an id") {
                    expect(activity.id) == "2016-10-02T09:31:26.000Z"
                }

                it("should have an sport") {
                    expect(activity.sport) == .biking
                }

                it("should have a lap with a start time") {
                    expect(activity.laps?.first!.startTime?.description) == "2016-10-02 09:31:26 +0000"
                }

                it("should have a lap with total time") {
                    expect(activity.laps?.first!.totalTime) == 123
                }

                it("should have a lap with total distance in meters") {
                    expect(activity.laps?.first!.totalDistance) == 456
                }

                it("should have a lap with maximum speed") {
                    expect(activity.laps?.first!.maximumSpeed) == 17
                }

                it("should have a lap with calories") {
                    expect(activity.laps?.first!.calories) == 1007
                }

                it("should have a lap with an average heart rate") {
                    expect(activity.laps?.first!.averageHeartRate) == 155
                }

                it("should have a lap with a maximum heart rate") {
                    expect(activity.laps?.first!.maximumHeartRate) == 175
                }

                it("should have a lap with a cadence") {
                    expect(activity.laps?.first!.cadence) == 77
                }

                it("should have a lap with a trigger method") {
                    expect(activity.laps?.first!.triggerMethod) == .manual
                }

                it("should have a lap with an intensity") {
                    expect(activity.laps?.first!.intensity) == .active
                }
            }

            describe("activity track point data") {
                var point: Point!

                beforeEach {
                    let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                    + "<Activities>"
                                        + "<Activity Sport='Biking'>"
                                            + "<Lap>"
                                                + "<Track>"
                                                    + "<Trackpoint>"
                                                        + "<Time>2016-03-10T10:05:12+02:00</Time>"
                                                        + "<Position>"
                                                            + "<LatitudeDegrees>51.208845321089</LatitudeDegrees>"
                                                            + "<LongitudeDegrees>4.394159177318</LongitudeDegrees>"
                                                        + "</Position>"
                                                        + "<HeartRateBpm>"
                                                            + "<Value>155</Value>"
                                                        + "</HeartRateBpm>"
                                                        + "<Cadence>77</Cadence>"
                                                        + "<AltitudeMeters>100</AltitudeMeters>"
                                                        + "<DistanceMeters>456</DistanceMeters>"
                                                    + "</Trackpoint>"
                                                + "</Track>"
                                            + "</Lap>"
                                        + "</Activity>"
                                    + "</Activities>"
                                + "</TrainingCenterDatabase>"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .tcx).parse()

                    point = file.activities?.first?.laps?.first?.points?.first!
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

                it("should have a cadence") {
                    expect(point.cadence) == 77
                }

                it("should have a heart rate") {
                    expect(point.heartRate) == 155
                }
            }

            describe("empty activity track point data") {
                var point: Point!

                beforeEach {
                    let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                    + "<Activities>"
                                        + "<Activity Sport='Biking'>"
                                            + "<Id>2016-10-02T09:31:26.000Z</Id>"
                                            + "<Lap StartTime='2016-10-02T09:31:26.000Z'>"
                                                + "<Track>"
                                                    + "<Trackpoint>"
                                                        + "<Position>"
                                                            + "<LatitudeDegrees>51.208845321089</LatitudeDegrees>"
                                                            + "<LongitudeDegrees>4.394159177318</LongitudeDegrees>"
                                                        + "</Position>"
                                                    + "</Trackpoint>"
                                                + "</Track>"
                                            + "</Lap>"
                                        + "</Activity>"
                                    + "</Activities>"
                                + "</TrainingCenterDatabase>"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .tcx).parse()

                    point = file.activities?.first?.laps?.first?.points?.first!
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

                it("should not have a cadence") {
                    expect(point.cadence).to(beNil())
                }

                it("should not have a heart rate") {
                    expect(point.heartRate).to(beNil())
                }
            }
        }
    }
}
