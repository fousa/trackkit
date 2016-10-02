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
                                + "</Author>"
                            + "</TrainingCenterDatabase>"
                let data = content.data(using: .utf8)
                file = try! TrackParser(data: data, type: .tcx).parse()
            }
            
            context("metadata") {
                it("should have a name") {
                    expect(file.author?.name) == "Jelle Vandebeeck"
                }
            }
        }
    }
}
