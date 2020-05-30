//
//  DateMangerTests.swift
//  AirbnbTests
//
//  Created by delma on 2020/05/29.
//  Copyright © 2020 jinie. All rights reserved.
//

import XCTest
@testable import Airbnb

class DateMangerTests: XCTestCase {

    var dateManager: DateManager!
    
    override func setUp() {
        dateManager = DateManager()
    }
    
    func testCountOfDays() {
        let july = dateManager.countOfDays(year: 2020, month: 7)
        XCTAssertEqual(july, 31)
        let september = dateManager.countOfDays(year: 2020, month: 9)
        XCTAssertEqual(september, 30)
    }
}
