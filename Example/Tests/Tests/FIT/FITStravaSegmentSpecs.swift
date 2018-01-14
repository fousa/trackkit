//
//  FITStravaSegmentSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 14/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class FITStravaSegmentSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Strava Segment") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITStravaSegmentSpecs.self).url(forResource: "Strava Segment", withExtension: "fit")!
                    let data = try! Data(contentsOf: url)
                    file = try! TrackParser(data: data, type: .fit).parse()
                }
                
                it("should not have activities") {
                    expect(file.activities?.count) == 0
                }
                
                it("should have one course") {
                    expect(file.courses?.count) == 1
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.courses?.first?.points?.last!
                    }
                    
                    it("should have some points") {
                        expect(file.courses?.first?.points?.count) == 297
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "1989-12-31 00:03:49 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(51.2264, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(4.4002, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(7.6, within: 0.0001))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(2259.3999, within: 0.0001))
                    }
                }
            }
        }
    }
}



