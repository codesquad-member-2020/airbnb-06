//
//  AccommodationListUseCase.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

struct AccommodationListUseCase {
    var headers: HTTPHeaders = [:]
    
    class AccommodationListRequest: Requestable {
        var path: String = EndPoints.defaultURL + EndPoints.listings
        var method: HTTPMethod = .get
        var checkIn: String?
        var checkOut: String?
        var numGuests: String?
        var numPrice: String?
        var maxPrice: String?
        var offset: String?
        var limit: String?
        
        init(checkIn: String? = nil, checkOut: String? = nil, numGuests: String? = nil, numPrice: String? = nil, maxPrice: String? = nil, offset: String? = nil, limit: String? = nil) {
            self.checkIn = checkIn
            self.checkOut = checkOut
            self.numGuests = numGuests
            self.numPrice = numPrice
            self.maxPrice = maxPrice
            self.offset = offset
            self.limit = limit
        }
        
        func queryDate(checkIn: String, checkOut: String) {
            var urlComponent = URLComponents(url: URL(string: path)!, resolvingAgainstBaseURL: false)
            
            urlComponent?.queryItems?.append(URLQueryItem(name: checkIn, value: checkIn))
            urlComponent?.queryItems?.append(URLQueryItem(name: checkIn, value: checkIn))
            
            self.path = urlComponent!.url!.absoluteString
        }
    }
    
    func request(id: Int?, handler: @escaping (Any) -> Void) {
       
    }
    
    
}
