//
//  RedditTests.swift
//  RedditTests
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import XCTest
@testable import Reddit

class RedditTests: XCTestCase {

   func testCommentsConverter(){
        var count = 58953
        var converted = UnitConverter.convertToKs(count)
        XCTAssertEqual(converted, "58.9k")
        count = 589
        converted = UnitConverter.convertToKs(count)
        XCTAssertEqual(converted, "589")
        count = 1589
        converted = UnitConverter.convertToKs(count)
        XCTAssertEqual(converted, "1.5k")
    }

}
