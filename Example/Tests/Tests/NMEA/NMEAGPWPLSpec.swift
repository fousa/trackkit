//
//  NMEAGPWPLSpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 06/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class NMEAGPWPLSpec: QuickSpec {
    override func spec() {
        describe("GPWPL") {
            it("should not have records") {
                let content = "123"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .nmea).parse()

                expect(file.waypoints).to(beNil())
                expect(file.records).to(beNil())
            }

            context("record point data") {
                var point: Point!
                var file: File!

                beforeEach {
                    let content = "$GPWPL,3723.46587704,N,12202.26957864,W,EBBT*62"
                    let data = content.data(using: .utf8)
                    file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.waypoints?.first!
                }

                it("should have no records") {
                    expect(file.records).to(beNil())
                }

                it("should have a wpl point record type") {
                    expect(point.recordType) == .wpl
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should have a waypoint name") {
                    expect(point.name) == "EBBT"
                }
            }

            context("empty record point data") {
                var point: Point!

                beforeEach {
                    let content = "$GPWPL,3723.46587704,N,12202.26957864,W,"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.waypoints?.first!
                }

                it("should have a wpl point record type") {
                    expect(point.recordType) == .wpl
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should not have a waypoint name") {
                    expect(point.name) == ""
                }
            }
        }
    }
}
