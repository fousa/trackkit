//
//  FITLiloSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 14/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Foundation
import TrackKit

class FITLiloSpecs: QuickSpec {
    override func spec() {
        describe("FIT") {
            context("Lilo") {
                var file: File!
                beforeEach {
                    let url = Bundle(for: FITLiloSpecs.self).url(forResource: "Lilo", withExtension: "fit")!
                    let data = try! Data(contentsOf: url)
                    file = try! TrackParser(data: data, type: .fit).parse()
                }
                
                it("should have one course") {
                    expect(file.courses?.count) == 1
                }
                
                it("should have no activity") {
                    expect(file.activities?.count) == 0
                }
                
                context("points") {
                    var point: Point!
                    beforeEach {
                        point = file.courses?.first?.points?.last!
                    }
                    
                    it("should have a track point time") {
                        expect(point.time?.description) == "2016-08-18 20:07:04 +0000"
                    }
                    
                    it("should have a coordinate") {
                        expect(point.coordinate?.latitude).to(beCloseTo(51.3066, within: 0.0001))
                        expect(point.coordinate?.longitude).to(beCloseTo(4.2904, within: 0.0001))
                    }
                    
                    it("should have a altitude in meters") {
                        expect(point.elevation).to(beCloseTo(2, within: 0.0001))
                    }
                    
                    it("should have a distance in meters") {
                        expect(point.distance).to(beCloseTo(15764.5498, within: 0.0001))
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
