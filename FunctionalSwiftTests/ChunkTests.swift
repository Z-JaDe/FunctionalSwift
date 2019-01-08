//
//  ChunkTests.swift
//  FunctionalSwiftTests
//
//  Created by 郑军铎 on 2019/1/8.
//  Copyright © 2019 zjade. All rights reserved.
//

import XCTest
@testable import FunctionalSwift

class ChunkTests: XCTestCase {
    func testCore() {
        XCTAssertTrue("11111".chunk([1,2,0]).map(String.init) == ["1","11","11"])
        XCTAssertTrue("11111".chunk([1,0,2]).map(String.init) == ["1","1","11","1"])
        XCTAssertTrue("11111".chunk([0]).map(String.init) == ["11111"])
        XCTAssertTrue("11111".chunk([1]).map(String.init) == ["1","1111"])
        XCTAssertTrue("11111".chunk([1,0]).map(String.init) == ["1", "1", "1", "1", "1"])
    }
}
