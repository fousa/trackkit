//
//  GPXSpeedTest.swift
//  Tests
//
//  Created by Jelle Vandebeeck on 05/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import TrackKit

class GPXBenchmarkTest: XCTestCase {
    func testPerformance() {
        let url = Bundle(for: GPXBenchmarkTest.self).url(forResource: "GPX Benchmark", withExtension: "gpx")!
        
        self.measure {
            _ = try! ImprovedParser(fileURL: url).parse()
        }
    }
}
