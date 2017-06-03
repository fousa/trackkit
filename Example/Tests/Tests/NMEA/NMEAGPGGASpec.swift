//
//  NMEAGPGGASpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 01/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class NMEAGPGGASpec: QuickSpec {
    override func spec() {
        describe("GPGGA") {
            it("should not have records") {
                let content = "123"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .nmea).parse()

                expect(file.records).to(beNil())
            }

            describe("record point data") {
                var point: Point!

                beforeEach {
                    let content = "$GPGGA,172814.0,3723.46587704,N,12202.26957864,W,2,6,1.2,18.893,M,-25.669,M,2.0,0031*4F"
                    let data = content.data(using: .utf8)
                    let file = try! TrackParser(data: data, type: .nmea).parse()

                    point = file.records?.first!
                }

                fit("should have a gga point record type") {
                    expect(point.recordType) == .gga
                }

                it("should have a track point time") {
                    expect(point.time?.description).to(endWith("17:28:14 +0000"))
                }

                it("should have a coordinate") {
                    //                    37°23.46587704'N
                    //                    122°02.26957864'W
                    expect(point.coordinate?.latitude) == 51.208845321089
                    expect(point.coordinate?.longitude) == 4.394159177318
                }

                it("should have a gpx quality indicator") {
                    expect(point.gpsQuality) == .differentialGPSFix
                }

                it("should have a number of satellites") {
                    expect(point.numberOfSatellites) == 6
                }

                it("should have a horizontal dilution of precision") {
                    expect(point.horizontalDilutionOfPrecision) == 1.2
                }

                it("should have a main sea level height") {
                    expect(point.meanSeaLevelHeight) == 18.893
                }

                it("should have a height of geoid") {
                    expect(point.heightOfGeoid) == -25.669
                }

                it("should have a time since last update") {
                    expect(point.timeSinceLastUpdate) == 2.0
                }

                it("should have a station id") {
                    expect(point.stationId) == 0031
                }
            }
        }
    }
}
