//
//  FITRouteSpecs.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 13/01/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import TrackKit

class FITActivitySpecs: QuickSpec {
    override func spec() {
        fdescribe("activities") {
            it("should not have activities") {
                let url = Bundle(for: FITActivitySpecs.self).url(forResource: "no-activities", withExtension: "fit")!
                let data = try! Data(contentsOf: url)
                let file = try! TrackParser(data: data, type: .fit).parse()

                expect(file.activities).to(beNil())
            }
            
            context("activity data") {
                var file: File!
                var activity: Activity!
                beforeEach {
                    let url = Bundle(for: FITActivitySpecs.self).url(forResource: "activities", withExtension: "fit")!
                    let data = try! Data(contentsOf: url)
                    file = try! TrackParser(data: data, type: .fit).parse()
                    
                    activity = file.activities?.first!
                }
                
                it("should have some activities") {
                    expect(file.activities?.count) == 1
                }
            }
        }
    }
}
