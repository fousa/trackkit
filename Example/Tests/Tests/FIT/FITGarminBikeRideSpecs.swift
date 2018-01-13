//
//  FITGarminBikeRideSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class FITGarminBikeRideSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Garmin Bike Ride") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITGarminBikeRideSpecs.self).url(forResource: "Garmin Bike Ride", withExtension: "fit")!
                    let data = try! Data(contentsOf: url)
                    file = try! TrackParser(data: data, type: .fit).parse()
                }
                
                it("should not have routes") {
                    expect(file.courses).to(beNil())
                }
                
                it("should have one activity") {
                    expect(file.activities?.count) == 1
                }
                
                context("laps") {
                    var activity: Activity!
                    beforeEach {
                        activity = file.activities?.first!
                    }
                    
                    it("should have some laps") {
                        expect(activity.laps?.count) == 1
                    }
                    
                    it("should have a lap start time") {
                        expect(activity.laps?.first?.startTime?.description) == "2017-04-27 17:39:28 +0000"
                    }
                    
                    it("should have a lap total time") {
                        expect(activity.laps?.first?.totalTime).to(beCloseTo(577.08, within: 0.0001))
                    }
                    
                    it("should have a lap total distance") {
                        expect(activity.laps?.first?.totalDistance).to(beCloseTo(3458.3201, within: 0.0001))
                    }
                    
                    it("should have a lap maximum speed") {
                        expect(activity.laps?.first?.maximumSpeed).to(beCloseTo(8.6220, within: 0.0001))
                    }
                    
                    it("should have a lap calories") {
                        expect(activity.laps?.first?.calories) == 46
                    }
                    
                    it("should have a lap average heart rate") {
                        expect(activity.laps?.first?.averageHeartRate) == 124
                    }
                    
                    it("should have a lap maximum heart rate") {
                        expect(activity.laps?.first?.maximumHeartRate) == 139
                    }
                    
                    it("should have a lap cadence") {
                        expect(activity.laps?.first?.cadence) == 88
                    }
                    
                    it("should have some points") {
                        expect(activity.laps?.first?.points?.count) == 132
                    }
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.activities?.first?.laps?.first?.points?.first!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2017-04-27 17:50:09 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(51.1658, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(4.4516, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(10.2000, within: 0.1))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(23458.3203, within: 0.0001))
                    }
                    
                    it("should have a cadence") {
                        expect(point.cadence) == 0
                    }
                    
                    it("should have a heart rate") {
                        expect(point.heartRate) == 107
                    }
                }
            }
        }
    }
}

