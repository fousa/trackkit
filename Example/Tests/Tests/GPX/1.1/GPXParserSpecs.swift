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
        fdescribe("parser") {
            it("should be successful") {
                expect { try ImprovedParser(data: Data(), fileExtension: "gpx") }.notTo(throwError())
            }

            it("should throw an data error") {
                expect {
                    try ImprovedParser(data: nil, fileExtension: "gpx")
                }.to(throwError(ImprovedParserError.noData))
            }

            it("should throw an parse error") {
                expect {
                    try ImprovedParser(data: Data(), fileExtension: "gpx").parse()
                }.to(throwError(ImprovedParserError.invalidFormat))
            }

            it("should throw an invalid version error") {
                let content = "<gpx version='0.0'></gpx>"
                let data = content.data(using: .utf8)
                expect {
                    try ImprovedParser(data: data, fileExtension: "gpx").parse()
                }.to(throwError(ImprovedParserError.invalidVersion))
            }

            it("should not throw an invalid version error for 1.0") {
                let content = "<gpx version='1.0'></gpx>"
                let data = content.data(using: .utf8)
                expect {
                    try ImprovedParser(data: data, fileExtension: "gpx").parse()
                }.toNot(throwError(ImprovedParserError.invalidVersion))
            }

            it("should not throw an invalid version error for 1.1") {
                let content = "<gpx version='1.1'></gpx>"
                let data = content.data(using: .utf8)
                expect {
                    try ImprovedParser(data: data, fileExtension: "gpx").parse()
                }.toNot(throwError(ImprovedParserError.invalidVersion))
            }
        }
    }
}
