//
//  AccommodationListUseCase.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

struct AccommodationUseCase {
    let request = AccommodationListRequest()
    
    func request(id: Int?, name: QueryParameters?, value: String?, handler: @escaping (Any) -> Void) {
        if let id = id { request.append(id: id) }
        
    }
    
    
}

class AccommodationListRequest: Request, Queryable, URLRequestConvertible {
    var path: String = EndPoints.defaultURL + EndPoints.listings
    var method: HTTPMethod = .get
    var headers: HTTPHeaders?
    var queryItems: [URLQueryItem] = []
    
    func append(name: QueryParameters, value: String) {
        let queryItem = URLQueryItem(name: name.description, value: value)
        queryItems.append(queryItem)
    }
    
    func append(id: Int) {
        path += "/\(id)"
    }
    
    func setToken() {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
        headers = ["Authorization": token]
    }
    
    func asURLRequest() throws -> URLRequest {
        var request: URLRequest
        request = URLRequest(url: URL(string: path)!)
        request.httpMethod = self.method.rawValue
        guard let headers = headers else { return request }
        request.headers = headers
        return request
    }
}
