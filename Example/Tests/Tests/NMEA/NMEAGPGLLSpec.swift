//
//  NMEAGPGLLSpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 05/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class NMEAGPGLLSpec: QuickSpec {
    override func spec() {
        describe("GPGLL") {
            it("should not have records") {
                let content = "123"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .nmea).parse()

                expect(file.records).to(beNil())
                expect(file.waypoints).to(beNil())
            }

            context("record point data") {
                var point: Point!
                var file: File!

                beforeEach {
                    let content = "$GPGLL,3723.46587704,N,12202.26957864,W,172814.0,A*4F"
                    let data = content.data(using: .utf8)
                    file = try! TrackParser(data: data, type: .nmea).parse()
                    point = file.records?.first!
                }

                it("should have no waypoints") {
                    expect(file.waypoints).to(beNil())
                }

                it("should have a gll point record type") {
                    expect(point.recordType) == .gll
                }

                it("should have a track point time") {
                    expect(point.time?.description).to(endWith("17:28:14 +0000"))
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should have a navigation receiver warning") {
                    expect(point.navigationReceiverWarning) == .ok
                }
            }

            context("empty record point data") {
                var point: Point!

                beforeEach {
                    let content = "$GPGLL,3723.46587704,N,12202.26957864,W,"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.records?.first!
                }

                it("should have a gll point record type") {
                    expect(point.recordType) == .gll
                }

                it("should not have a time") {
                    expect(point.time?.description).to(beNil())
                }

                it("should have a coordinate") {
                    expect(point.coordinate?.latitude) == 37.391097950666669
                    expect(point.coordinate?.longitude) == -122.03782631066667
                }

                it("should not have a navigation receiver warning") {
                    expect(point.navigationReceiverWarning).to(beNil())
                }
            }
        }
    }
}
