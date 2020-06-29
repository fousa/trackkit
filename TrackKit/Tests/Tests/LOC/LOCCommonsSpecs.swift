//
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/12/2016.
//

import Quick
import Nimble
import TrackKit

class LOCCommonSpec: QuickSpec {
    override func spec() {
        var file: File!

        describe("common data") {
            beforeEach {
                let content = "<loc src='Groundspeak' version='1.0'>"
                                + "<waypoint></waypoint>"
                            + "</loc>"
                let data = content.data(using: .utf8)
                file = try! TrackParser(data: data, type: .loc).parse()
            }

            it("should have a source") {
                expect(file.source) == "Groundspeak"
            }

            context("empty file") {
                beforeEach {
                    let content = "<loc version='1.0'></loc>"
                    let data = content.data(using: .utf8)
                    file = try! TrackParser(data: data, type: .loc).parse()
                }

                it("should not have a source") {
                    expect(file.source).to(beNil())
                }
            }
        }
    }
}
