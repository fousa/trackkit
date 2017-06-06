//
//  NMEAParserSpec.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 01/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class NMEAParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect { try TrackParser(data: Data(), type: .nmea) }.notTo(throwError())
            }

            it("should throw an data error") {
                expect { try TrackParser(data: nil, type: .nmea) }.to(throwError(TrackParseError.invalidData))
            }

            it("should throw an parse error") {
                expect { try TrackParser(data: Data(), type: .nmea).parse() }.to(throwError(TrackParseError.invalidData))
            }

            it("should not throw an invalid version error") {
                let content = "$GPGGA,092750.000,5321.6802,N,00630.3372,W,1,8,1.03,61.7,M,55.2,M,,*76"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .nmea).parse() }.toNot(throwError(TrackParseError.invalidVersion))
            }

            it("should return the correct version") {
                let content = "$GPGGA,092750.000,5321.6802,N,00630.3372,W,1,8,1.03,61.7,M,55.2,M,,*76"
                let data = content.data(using: .utf8)
                let file = try! TrackParser(data: data, type: .nmea).parse()
                expect(file.typeVersion.versionString) == "NMEA-0183"
            }
        }
    }
}
