//
//  NMEAGPRMCSpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 05/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class NMEAGPRMCSpec: QuickSpec {
    override func spec() {
        describe("GPRMC") {
            it("should not have records") {
                let content = "123"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .nmea).parse()

                expect(file.records).to(beNil())
            }

            context("record point data") {
                var point: Point!

                beforeEach {
                    let content = "$GPRMC,172814,A,3723.46587704,N,12202.26957864,W,001.5,240.0,130998,011.3,E*62"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.records?.first!
                }

                it("should have a rmc point record type") {
                    expect(point.recordType) == .rmc
                }

                it("should have a track point time") {
                    expect(point.time?.description) == "1998-09-13 17:28:14 +0000"
                }

                it("should have a navigation receiver warning") {
                    expect(point.navigationReceiverWarning) == .ok
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should have a speed") {
                    expect(point.speed) == 1.5
                }

                it("should have a track angle") {
                    expect(point.trackAngle) == 240.0
                }

                it("should have a magnetic variation") {
                    expect(point.magneticVariation) == 11.3
                }
            }

            context("alternat record point data") {
                var point: Point!

                beforeEach {
                    let content = "$GPRMC,172814,A,3723.46587704,N,12202.26957864,W,001.5,240.0,130998,011.3,W*62"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.records?.first!
                }

                it("should have a magnetic variation") {
                    expect(point.magneticVariation) == -11.3
                }
            }

            context("empty record point data") {
                var point: Point!

                beforeEach {
                    let content = "$GPRMC,,,3723.46587704,N,12202.26957864,W,"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.records?.first!
                }

                it("should have a rmc point record type") {
                    expect(point.recordType) == .rmc
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should not have a navigation receiver warning") {
                    expect(point.navigationReceiverWarning).to(beNil())
                }

                it("should not have a speed") {
                    expect(point.speed).to(beNil())
                }

                it("should not have a track angle") {
                    expect(point.trackAngle).to(beNil())
                }

                it("should not have a magnetic variation") {
                    expect(point.magneticVariation).to(beNil())
                }
            }
        }
    }
}
