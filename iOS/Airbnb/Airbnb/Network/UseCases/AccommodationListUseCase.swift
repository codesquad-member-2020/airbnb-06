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
    
    class AccommodationListRequest: Request, Queryable, URLRequestConvertible {
        var path: String = EndPoints.defaultURL + EndPoints.listings
        var method: HTTPMethod = .get
        var headers: HTTPHeaders?
        var queryItems: [URLQueryItem] = []
        
        func append(name: QueryParameters, value: String) {
            let queryItem = URLQueryItem(name: name.description, value: value)
            queryItems.append(queryItem)
        }
        
        func setToken() {
            guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
            headers = ["Authorization": token]
        }
        
        func asURLRequest() throws -> URLRequest {
            var request: URLRequest
            request = URLRequest(url: URL(string: path)!)
            request.httpMethod = self.method.rawValue
            guard let header = headers else { return request }
            request.headers = header
            return request
        }
    }
    
    func request(id: Int?, handler: @escaping (Any) -> Void) {
        
    }
    
    
}
