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
    
    func testSaveValueWithKey() throws {
        let key = "SQajUN4XZpWlRpVpBF6vlXzv4gA3"
        try Archiver.save(value: "Brad", key: key)
        XCTAssert(try Archiver.restore(key: key) == "Brad")
        try Archiver.save(value: nil, key: key)
        do {
            _ = try Archiver.restore(type: String.self, key: key)
            XCTFail()
        } catch {}
    }
    
    func testRestoreFromBundle() throws {
        let bundle = Bundle(identifier: "com.bradhilton.ConvertibleArchiverTests")
        XCTAssert(try Archiver.restore(key: "BundleData", bundle: bundle) == "Hello, world")
    }
    
}
