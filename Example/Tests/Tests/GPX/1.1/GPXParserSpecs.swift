//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//

import Quick
import Nimble
import TrackKit

class GPXParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect { try TrackParser(data: Data(), type: .gpx) }.notTo(throwError())
            }

            it("should throw an data error") {
                expect { try TrackParser(data: nil, type: .gpx) }.to(throwError(TrackParseError.invalidData))
            }

            it("should throw an parse error") {
                expect { try TrackParser(data: Data(), type: .gpx).parse() }.to(throwError(TrackParseError.invalidFormat))
            }

            it("should throw an invalid version error") {
                let content = "<gpx version='0.0'></gpx>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .gpx).parse() }.to(throwError(TrackParseError.invalidVersion))
            }

            it("should not throw an invalid version error for 1.0") {
                let content = "<gpx version='1.0'></gpx>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .gpx).parse() }.to(throwError(TrackParseError.invalidVersion))
            }
            
            it("should not throw an invalid version error for 1.1") {
                let content = "<gpx version='1.1'></gpx>"
                let data = content.data(using: .utf8)
                expect { try TrackParser(data: data, type: .gpx).parse() }.toNot(throwError(TrackParseError.invalidVersion))
            }
        }
    }
}
