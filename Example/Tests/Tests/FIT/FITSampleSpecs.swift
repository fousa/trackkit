//
//  FITSampleSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class FITSampleSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Sample") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITSampleSpecs.self).url(forResource: "Sample", withExtension: "fit")!
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
                        expect(activity.laps?.count) == 6
                    }
                    
                    it("should have a lap start time") {
                        expect(activity.laps?.last?.startTime?.description) == "2015-01-20 14:03:36 +0000"
                    }
                    
                    it("should have a lap total time") {
                        expect(activity.laps?.last?.totalTime).to(beCloseTo(25.1270, within: 0.0001))
                    }
                    
                    it("should have a lap total distance") {
                        expect(activity.laps?.last?.totalDistance).to(beCloseTo(65.73, within: 0.0001))
                    }
                    
                    it("should have a lap maximum speed") {
                        expect(activity.laps?.last?.maximumSpeed).to(beCloseTo(2.6410, within: 0.0001))
                    }
                    
                    it("should have a lap calories") {
                        expect(activity.laps?.last?.calories) == 4
                    }
                    
                    it("should have a lap average heart rate") {
                        expect(activity.laps?.last?.averageHeartRate).to(beNil())
                    }
                    
                    it("should have a lap maximum heart rate") {
                        expect(activity.laps?.last?.maximumHeartRate).to(beNil())
                    }
                    
                    it("should have a lap cadence") {
                        expect(activity.laps?.last?.cadence) == 81
                    }
                    
                    it("should have some points") {
                        expect(activity.laps?.last?.points?.count) == 3
                    }
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.activities?.first?.laps?.last?.points?.last!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2015-01-20 14:04:00 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(25.0628, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(121.6324, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(22.4, within: 0.0001))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(5065.73, within: 0.0001))
                    }
                    
                    it("should have a cadence") {
                        expect(point.cadence) == 80
                    }
                    
                    it("should have a heart rate") {
                        expect(point.heartRate).to(beNil())
                    }
                }
            }
        }
    }
}


