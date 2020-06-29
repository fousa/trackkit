//
//  FITMultiActivitiesSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Foundation
import TrackKit

class FITMultiActivitiesSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Multi Activities") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITSampleSpecs.self).url(forResource: "Multi Activities", withExtension: "fit")!
                    let data = try! Data(contentsOf: url)
                    file = try! TrackParser(data: data, type: .fit).parse()
                }
                
                it("should not have routes") {
                    expect(file.courses?.count) == 0
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
                        expect(activity.laps?.count) == 5
                    }
                    
                    it("should have a lap start time") {
                        expect(activity.laps?.last?.startTime?.description) == "2014-08-06 17:02:31 +0000"
                    }
                    
                    it("should have a lap total time") {
                        expect(activity.laps?.last?.totalTime).to(beCloseTo(423.8410, within: 0.0001))
                    }
                    
                    it("should have a lap total distance") {
                        expect(activity.laps?.last?.totalDistance).to(beCloseTo(462.45, within: 0.0001))
                    }
                    
                    it("should have a lap maximum speed") {
                        expect(activity.laps?.last?.maximumSpeed).to(beCloseTo(2.361, within: 0.0001))
                    }
                    
                    it("should have a lap calories") {
                        expect(activity.laps?.last?.calories) == 104
                    }
                    
                    it("should have a lap average heart rate") {
                        expect(activity.laps?.last?.averageHeartRate) == 154
                    }
                    
                    it("should have a lap maximum heart rate") {
                        expect(activity.laps?.last?.maximumHeartRate) == 154
                    }
                    
                    it("should have a lap cadence") {
                        expect(activity.laps?.last?.cadence) == 43
                    }
                    
                    it("should have some points") {
                        expect(activity.laps?.last?.points?.count) == 423
                    }
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.activities?.first?.laps?.last?.points?.last!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2014-08-06 17:09:34 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(38.8565, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(-94.7991, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(357.4, within: 0.0001))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(1040.3199, within: 0.0001))
                    }
                    
                    it("should have a cadence") {
                        expect(point.cadence) == 0
                    }
                    
                    it("should have a heart rate") {
                        expect(point.heartRate) == 154
                    }
                }
            }
        }
    }
}



