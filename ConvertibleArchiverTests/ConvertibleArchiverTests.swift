//
//  ConvertibleArchiverTests.swift
//  ConvertibleArchiverTests
//
//  Created by Bradley Hilton on 4/12/16.
//  Copyright © 2016 Brad Hilton. All rights reserved.
//

import XCTest
import ConvertibleArchiver

class ConvertibleArchiverTests: XCTestCase {
    
    func testSaveValueWithKey() {
        Archiver.save(value: "Brad", key: "Name")
        XCTAssert(Archiver.restore(key: "Name") == "Brad")
        Archiver.save(value: nil, key: "Name")
        XCTAssert(Archiver.restore(type: String.self, key: "Name") == nil)
    }
    
    func testRestoreFromBundle() {
        let bundle = Bundle(identifier: "com.bradhilton.ConvertibleArchiverTests")
        XCTAssert(Archiver.restore(key: "BundleData", bundle: bundle) == "Hello, world")
    }
    
}
