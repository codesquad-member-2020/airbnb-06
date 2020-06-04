//
//  Request.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var bodyParams: [String : Any]? { get }
    func setToken() -> HTTPHeaders?
}

extension Request {
    var method: HTTPMethod { return .GET }
    var headers: HTTPHeaders? { return nil }
    var bodyParams: [String : Any]? { return nil }
    func setToken() -> HTTPHeaders? {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return nil }
        let headers: HTTPHeaders = ["Authorization": token]
        return headers
    }
}

protocol Queryable {
    var queryItems: [URLQueryItem] { get }
    func append(name: QueryParameters, value: String)
}
