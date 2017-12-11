//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//

import Quick
import Nimble
import TrackKit

class TRACKParserSpec: QuickSpec {
    override func spec() {
        describe("parser") {
            it("should be successful") {
                expect { try TrackParser(data: Data(), type: .track) }.notTo(throwError())
            }

            it("should throw an data error") {
                expect { try TrackParser(data: nil, type: .track) }.to(throwError(TrackParseError.invalidData))
            }
        }
    }
}
