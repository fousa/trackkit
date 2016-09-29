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
            describe("Should parse gpx as gpx type") {
                let type = TrackType(fileExtension: "gpx")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "gpx"
            }
            
            describe("Should parse GPX as gpx type") {
                let type = TrackType(fileExtension: "GPX")
                expect(type).toNot(beNil())
                expect(type?.rawValue) == "gpx"
            }
        }
    }
}
