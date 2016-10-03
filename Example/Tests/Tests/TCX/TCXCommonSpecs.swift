//
//  TCXCommonTests.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 30/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class TCXCommonSpec: QuickSpec {
    override func spec() {
        var file: File!
        
        describe("common data") {
            beforeEach {
                let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'>"
                                // Author
                                + "<Author>"
                                    + "<Name>Jelle Vandebeeck</Name>"
                                    + "<Build>"
                                        + "<Version>"
                                            + "<VersionMajor>1</VersionMajor>"
                                            + "<VersionMinor>2</VersionMinor>"
                                            + "<BuildMajor>3</BuildMajor>"
                                            + "<BuildMinor>4</BuildMinor>"
                                        + "</Version>"
                                    + "</Build>"
                                    + "<LangID>en</LangID>"
                                    + "<PartNumber>000-00000-00</PartNumber>"
                                + "</Author>"
                            + "</TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                file = try! TrackParser(data: data, type: .tcx).parse()
            }
            
            context("metadata") {
                it("should have an author name") {
                    expect(file.author?.name) == "Jelle Vandebeeck"
                }

                it("should have an author version number") {
                    expect(file.author?.build?.version?.versionNumber) == "1.2"
                }

                it("should have an author build number") {
                    expect(file.author?.build?.version?.buildNumber) == "3.4"
                }

                it("should have an author language") {
                    expect(file.author?.language) == "en"
                }

                it("should have an author part number") {
                    expect(file.author?.partNumber) == "000-00000-00"
                }
            }

            context("empty file") {
                beforeEach {
                    let content = "<TrainingCenterDatabase xmlns='http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2'></TrainingCenterDatabase>"
                    let data = content.data(using: .utf8)
                    file = try! TrackParser(data: data, type: .tcx).parse()
                }

                it("should not have a creator name") {
                    expect(file.creator).to(beNil())
                }

                context("metadata") {
                    it("should not have an author name") {
                        expect(file.author?.name).to(beNil())
                    }

                    it("should not have an author version number") {
                        expect(file.author?.build?.version?.versionNumber).to(beNil())
                    }

                    it("should not have an author build number") {
                        expect(file.author?.build?.version?.buildNumber).to(beNil())
                    }

                    it("should not have an author language") {
                        expect(file.author?.language).to(beNil())
                    }

                    it("should not have an author part number") {
                        expect(file.author?.partNumber).to(beNil())
                    }
                }
            }
        }
    }
}
