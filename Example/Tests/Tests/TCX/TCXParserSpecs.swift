//
//  TCXParserTests.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class TCXParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect { try TrackParser(data: Data(), type: .tcx) }.notTo(throwError())
            }

            it("should throw an data error") {
                expect { try TrackParser(data: nil, type: .tcx) }.to(throwError(TrackParseError.invalidData))
            }

            it("should throw an parse error") {
                expect { try TrackParser(data: Data(), type: .tcx).parse() }.to(throwError(TrackParseError.invalidFormat))
            }

            it("should throw an invalid version error") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v1'></TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .tcx).parse() }.to(throwError(TrackParseError.invalidVersion))
            }

            it("should not throw an invalid version error") {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'></TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .tcx).parse() }.toNot(throwError(TrackParseError.invalidVersion))
            }
        }
    }
}
