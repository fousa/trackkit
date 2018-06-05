//
//  GPX10Spec.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 05/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class GPX10Spec: QuickSpec {
    override func spec() {
        fdescribe("GPX 1.0") {
            context("waypoints") {
                var file: ImprovedFile!
                var point: ImprovedPoint?
                beforeEach {
                    let url = Bundle(for: GPX10Spec.self).url(forResource: "GPX 1.0 Waypoint", withExtension: "gpx")!
                    file = try! ImprovedParser(fileURL: url).parse()
                    point = file.waypoints?.first
                }
                
                it("should have a some waypoints") {
                    expect(file.waypoints?.count) == 2
                }
                
                it("should have a coordinate") {
                    expect(point?.coordinate.latitude) == 41.2
                    expect(point?.coordinate.longitude) == -71.3
                }
                
                it("should have an elevation") {
                    expect(point?.elevation) == 1001
                }
                
                it("should have a timestamp") {
                    expect(point?.timestamp?.description) == "2016-03-10 08:05:12 +0000"
                }
                
                it("should have a name") {
                    expect(point?.name) == "A waypoint"
                }
                
                it("should have a description") {
                    expect(point?.description) == "A description"
                }
            }
            
            context("route") {
                var file: ImprovedFile!
                beforeEach {
                    let url = Bundle(for: GPX10Spec.self).url(forResource: "GPX 1.0 Route", withExtension: "gpx")!
                    file = try! ImprovedParser(fileURL: url).parse()
                }
                
                it("should have a some route points") {
                    expect(file.route?.points.count) == 3
                }
                
                it("should have a point") {
                    expect(file.route?.points.first).to(beAKindOf(ImprovedPoint.self))
                }
                
                it("should have a distance") {
                    expect(file.route?.distance).to(beCloseTo(222, within: 1.0))
                }
                
                it("should have no height gained") {
                    expect(file.route?.heighGained).to(beNil())
                }
            }
            
            context("route with meta") {
                var file: ImprovedFile!
                beforeEach {
                    let url = Bundle(for: GPX10Spec.self).url(forResource: "GPX 1.0 Route with Meta",
                                                                  withExtension: "gpx")!
                    file = try! ImprovedParser(fileURL: url).parse()
                }
                
                it("should have no height gained") {
                    expect(file.route?.heighGained).to(beCloseTo(60, within: 1.0))
                }
            }
            
            context("track") {
                var file: ImprovedFile!
                beforeEach {
                    let url = Bundle(for: GPX10Spec.self).url(forResource: "GPX 1.0 Track", withExtension: "gpx")!
                    file = try! ImprovedParser(fileURL: url).parse()
                }
                
                it("should have a some route points") {
                    expect(file.track?.points.count) == 4
                }
                
                it("should have a point") {
                    expect(file.track?.points.first).to(beAKindOf(ImprovedPoint.self))
                }
                
                it("should have a distance") {
                    expect(file.track?.distance).to(beCloseTo(333, within: 1.0))
                }
                
                it("should have no height gained") {
                    expect(file.track?.heighGained).to(beNil())
                }
                
                it("should have no duration") {
                    expect(file.track?.duration).to(beNil())
                }
                
                it("should have no average speed") {
                    expect(file.track?.averageSpeed).to(beNil())
                }
                
                it("should have no maximmum speed") {
                    expect(file.track?.maximumSpeed) == 0
                }
                
                it("should have no average heart rate") {
                    expect(file.track?.averageHeartRate) == 0
                }
                
                it("should have no maximmum heart rate") {
                    expect(file.track?.maximumHeartRate) == 0
                }
                
                it("should have no average cadence") {
                    expect(file.track?.averageCadence) == 0
                }
                
                it("should have no average temperature") {
                    expect(file.track?.averageTemperature).to(beNil())
                }
            }
            
            context("track with meta") {
                var file: ImprovedFile!
                beforeEach {
                    let url = Bundle(for: GPX10Spec.self).url(forResource: "GPX 1.0 Track with Meta",
                                                                  withExtension: "gpx")!
                    file = try! ImprovedParser(fileURL: url).parse()
                }
                
                it("should have height gained") {
                    expect(file.track?.heighGained).to(beCloseTo(80, within: 1.0))
                }
                
                it("should have duration") {
                    expect(file.track?.duration) == 300
                }
                
                it("should have average speed") {
                    expect(file.track?.averageSpeed).to(beCloseTo(1.1108, within: 0.0001))
                }
                
                it("should have maximmum speed") {
                    expect(file.track?.maximumSpeed).to(beCloseTo(1.8513, within: 0.0001))
                }
                
                it("should have no average heart rate") {
                    expect(file.track?.averageHeartRate) == 0
                }
                
                it("should have no maximmum heart rate") {
                    expect(file.track?.maximumHeartRate) == 0
                }
                
                it("should have no average cadence") {
                    expect(file.track?.averageCadence) == 0
                }
                
                it("should have no average temperature") {
                    expect(file.track?.averageTemperature).to(beNil())
                }
            }
        }
    }
}
