//
//  FITHealthFitSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 15/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Foundation
import TrackKit

class FITHealthFitSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("HealthFit Export") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITGarminBikeRideSpecs.self).url(forResource: "HealthFit", withExtension: "fit")!
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
                        expect(activity.laps?.count) == 1
                    }
                    
                    it("should have a lap start time") {
                        expect(activity.laps?.last?.startTime?.description).to(beNil())
                    }
                    
                    it("should have a lap total time") {
                        expect(activity.laps?.last?.totalTime).to(beNil())
                    }
                    
                    it("should have a lap total distance") {
                        expect(activity.laps?.last?.totalDistance).to(beNil())
                    }
                    
                    it("should have a lap maximum speed") {
                        expect(activity.laps?.last?.maximumSpeed).to(beNil())
                    }
                    
                    it("should have a lap calories") {
                        expect(activity.laps?.last?.calories).to(beNil())
                    }
                    
                    it("should have a lap average heart rate") {
                        expect(activity.laps?.last?.averageHeartRate).to(beNil())
                    }
                    
                    it("should have a lap maximum heart rate") {
                        expect(activity.laps?.last?.maximumHeartRate).to(beNil())
                    }
                    
                    it("should have a lap cadence") {
                        expect(activity.laps?.last?.cadence).to(beNil())
                    }
                    
                    it("should have some points") {
                        expect(activity.laps?.last?.points?.count) == 1620
                    }
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.activities?.first?.laps?.last?.points?.last!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2018-05-11 22:13:49 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(49.8698, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(-97.1051, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(234, within: 0.1))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(9625.7305, within: 0.0001))
                    }
                    
                    it("should have a cadence") {
                        expect(point.cadence).to(beNil())
                    }
                    
                    it("should have a heart rate") {
                        expect(point.heartRate).to(beNil())
                    }
                }
            }
        }
    }
}

