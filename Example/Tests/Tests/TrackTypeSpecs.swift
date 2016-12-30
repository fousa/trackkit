//
//  TrackTypeSpecs.swift
//  TrackKit
//
//  Created by Jelle Vandebeeck on 29/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class TrackTypeSpec: QuickSpec {
    override func spec() {
        context("GPX") {
            it("Should parse gpx as gpx type") {
                let type = TrackType(fileExtension: "gpx")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "gpx"
            }
            
            it("Should parse GPX as gpx type") {
                let type = TrackType(fileExtension: "GPX")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "gpx"
            }
        }
        
        context("TCX") {
            it("Should parse tcx as tcx type") {
                let type = TrackType(fileExtension: "tcx")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "tcx"
            }
            
            it("Should parse TCX as tcx type") {
                let type = TrackType(fileExtension: "TCX")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "tcx"
            }
        }

        context("LOC") {
            it("Should parse loc as loc type") {
                let type = TrackType(fileExtension: "loc")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "loc"
            }

            it("Should parse LOC as loc type") {
                let type = TrackType(fileExtension: "LOC")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "loc"
            }
        }

        context("Unknown") {
            describe("Should not parse the type") {
                let type = TrackType(fileExtension: "some")
                expect(type).to(beNil())
            }
        }
    }
}
