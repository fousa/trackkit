//
//  FITMultiSportSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class FITMultiSportSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Multi Sport") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITSampleSpecs.self).url(forResource: "Multi Sport", withExtension: "fit")!
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
                        expect(activity.laps?.count) == 20
                    }
                    
                    it("should have a lap start time") {
                        expect(activity.laps?.last?.startTime?.description) == "2014-04-06 16:38:44 +0000"
                    }
                    
                    it("should have a lap total time") {
                        expect(activity.laps?.last?.totalTime).to(beCloseTo(392.961, within: 0.0001))
                    }
                    
                    it("should have a lap total distance") {
                        expect(activity.laps?.last?.totalDistance).to(beCloseTo(1601.8, within: 0.01))
                    }
                    
                    it("should have a lap maximum speed") {
                        expect(activity.laps?.last?.maximumSpeed).to(beCloseTo(4.908, within: 0.001))
                    }
                    
                    it("should have a lap calories") {
                        expect(activity.laps?.last?.calories) == 12
                    }
                    
                    it("should have a lap average heart rate") {
                        expect(activity.laps?.last?.averageHeartRate) == 129
                    }
                    
                    it("should have a lap maximum heart rate") {
                        expect(activity.laps?.last?.maximumHeartRate) == 139
                    }
                    
                    it("should have a lap cadence") {
                        expect(activity.laps?.last?.cadence).to(beNil())
                    }
                    
                    it("should have some points") {
                        expect(activity.laps?.last?.points?.count) == 393
                    }
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.activities?.first?.laps?.last?.points?.last!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2014-04-06 16:45:16 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(29.2755, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(-94.8541, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(66.8, within: 0.1))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(20909.8008, within: 0.01))
                    }
                    
                    it("should have a cadence") {
                        expect(point.cadence).to(beNil())
                    }
                    
                    it("should have a heart rate") {
                        expect(point.heartRate) == 127
                    }
                }
            }
        }
    }
}




