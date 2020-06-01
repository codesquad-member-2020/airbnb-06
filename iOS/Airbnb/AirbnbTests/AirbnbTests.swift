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
    
    var accommodationUseCaseWithQueryItem: AccommodationUseCase!
    
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
    
    func addQueryItem() {
        accommodationUseCaseWithQueryItem = AccommodationUseCase(request: AccommodationRequests.list.request)
        accommodationUseCaseWithQueryItem.append(request: accommodationUseCaseWithQueryItem.request as! Queryable, name: .checkIn, value: "2020-06-02")
        accommodationUseCaseWithQueryItem.append(request: accommodationUseCaseWithQueryItem.request as! Queryable, name: .checkOut, value: "2020-06-22")
    }
    
    func testAddingQueryItemsEqualExpectation() {
        addQueryItem()
        do {
            let request = try? accommodationUseCaseWithQueryItem.request.asURLRequest()
            guard let url = request?.url?.absoluteString else { return }
            XCTAssertEqual(url, "http://52.78.203.80/api/listings?checkIn=2020-06-02&checkOut=2020-06-22")
        }catch {
            
        }
    }
    
    func testAddingQueryItemsNotEqualExpectation() {
        addQueryItem()
        do {
            let request = try? accommodationUseCaseWithQueryItem.request.asURLRequest()
            guard let url = request?.url?.absoluteString else { return }
            XCTAssertNotEqual(url, "http://52.78.203.80/api/listings")
        }catch {
            
        }
    }
    
    func testExistedToken() {
        let accommodationUseCaseWithToken = AccommodationUseCase(request: AccommodationRequests.detail.request)
        do {
            let request = try? accommodationUseCaseWithToken.request.asURLRequest()
            let urlToken = request?.headers.dictionary["Authorization"]
            let userDefaultsToken = UserDefaults.standard.object(forKey: "token") as? String
            XCTAssertEqual(urlToken, userDefaultsToken)
        } catch {
            
        }
        
    }
}
