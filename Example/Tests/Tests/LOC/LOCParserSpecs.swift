//
//  LOCParserSpecs.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class LOCParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect { try TrackParser(data: Data(), type: .loc) }.notTo(throwError())
            }

            it("should throw an data error") {
                expect { try TrackParser(data: nil, type: .loc) }.to(throwError(TrackParseError.invalidData))
            }

            it("should throw an parse error") {
                expect { try TrackParser(data: Data(), type: .loc).parse() }.to(throwError(TrackParseError.invalidFormat))
            }

            it("should throw an invalid version error") {
                let content = "<loc version='0.0'></loc>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .loc).parse() }.to(throwError(TrackParseError.invalidVersion))
            }

            it("should not throw an invalid version error for 1.0") {
                let content = "<loc version='1.0'></loc>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .loc).parse() }.to(throwError(TrackParseError.invalidVersion))
            }
        }
    }
}
