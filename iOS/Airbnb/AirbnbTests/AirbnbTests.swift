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
                let decodedData = try JSONDecoder().decode([Accommodation].self, from: data)
                let _ = try! XCTUnwrap(decodedData)
            } catch {
                
            }
        }
    }
    
    func testAddingQueryItems() {
        let accommodationUseCaseWithQueryItem = AccommodationUseCase(request: AccommodationRequests.list.request)
        accommodationUseCaseWithQueryItem.append(request: accommodationUseCaseWithQueryItem.request as! Queryable, name: .checkIn, value: "2020-06-02")
        accommodationUseCaseWithQueryItem.append(request: accommodationUseCaseWithQueryItem.request as! Queryable, name: .checkOut, value: "2020-06-22")
        
        do {
            let request = try? accommodationUseCaseWithQueryItem.request.asURLRequest()
            guard let url = request?.url?.absoluteString else { return }
            XCTAssertEqual(url, "http://52.78.203.80/api/listings?checkIn=2020-06-02&checkOut=2020-06-22")
            XCTAssertNotEqual(url, "http://52.78.203.80/api/listings")
        }catch {
            
        }
        
    }
}
