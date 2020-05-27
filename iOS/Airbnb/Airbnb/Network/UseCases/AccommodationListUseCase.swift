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
            guard var urlComponent = URLComponents(string: path) else { return }
           
            let queryItems: [URLQueryItem] = [URLQueryItem(name: "checkIn", value: checkIn),
                                              URLQueryItem(name: "checkOut", value: checkOut)
            ]
            urlComponent.queryItems = queryItems
            self.path = urlComponent.url!.absoluteString
        }
        
        func makeRequest() -> URLRequest? {
            var request: URLRequest?
            request = URLRequest(url: URL(string: path)!)
            request?.httpMethod = self.method.rawValue
            return request
        }
    }
    
    func request(id: Int?, handler: @escaping (Any) -> Void) {
        let req = AccommodationListRequest()
        req.queryDate(checkIn: "2020-03-01", checkOut: "2020-04-01")
        let request = req.makeRequest()!
        print(request.url)
        AF.request(request).responseJSON { jsonData in
            print(jsonData)
        }
        
    }
    
    
}
