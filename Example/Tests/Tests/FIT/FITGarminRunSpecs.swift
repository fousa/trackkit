//
//  FITGarminRunSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class FITGarminRunSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Garmin Run") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITGarminRunSpecs.self).url(forResource: "Garmin Run", withExtension: "fit")!
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
                        expect(activity.laps?.count) == 14
                    }
                    
                    it("should have a lap start time") {
                        expect(activity.laps?.last?.startTime?.description) == "2016-11-14 19:12:29 +0000"
                    }
                    
                    it("should have a lap total time") {
                        expect(activity.laps?.last?.totalTime).to(beCloseTo(57.9800, within: 0.0001))
                    }
                    
                    it("should have a lap total distance") {
                        expect(activity.laps?.last?.totalDistance).to(beCloseTo(165.78, within: 0.0001))
                    }
                    
                    it("should have a lap maximum speed") {
                        expect(activity.laps?.last?.maximumSpeed).to(beCloseTo(2.9210, within: 0.0001))
                    }
                    
                    it("should have a lap calories") {
                        expect(activity.laps?.last?.calories) == 12
                    }
                    
                    it("should have a lap average heart rate") {
                        expect(activity.laps?.last?.averageHeartRate) == 163
                    }
                    
                    it("should have a lap maximum heart rate") {
                        expect(activity.laps?.last?.maximumHeartRate) == 167
                    }
                    
                    it("should have a lap cadence") {
                        expect(activity.laps?.last?.cadence) == 80
                    }
                    
                    it("should have some points") {
                        expect(activity.laps?.last?.points?.count) == 9
                    }
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.activities?.first?.laps?.last?.points?.first!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2016-11-14 19:13:26 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(51.1669, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(4.4525, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(14.8000, within: 0.0001))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(10434.5801, within: 0.0001))
                    }
                    
                    it("should have a cadence") {
                        expect(point.cadence) == 82
                    }
                    
                    it("should have a heart rate") {
                        expect(point.heartRate) == 166
                    }
                }
            }
        }
    }
}
