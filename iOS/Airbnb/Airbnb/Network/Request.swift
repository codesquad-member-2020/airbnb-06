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
    case get, post, put, patch, delete
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var bodyParams: [String : Any]? { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders? { return nil }
    var bodyParams: [String : Any]? { return nil }
}

protocol Queryable {
    var queryItems: [URLQueryItem] { get }
    func append(name: QueryParameters, value: String)
}
