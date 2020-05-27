//
//  AirbnbTests.swift
//  AirbnbTests
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import XCTest
@testable import Airbnb

class AirbnbTests: XCTestCase {
    
    func testDecode() {
        if let path = Bundle.main.path(forResource: "FakeAccommodationList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decodedData = try JSONDecoder().decode(Accommodation.self, from: data)
                let _ = try! XCTUnwrap(decodedData)
            } catch {

            }
        }
    }
}
