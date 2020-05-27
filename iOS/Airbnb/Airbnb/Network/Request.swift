//
//  Request.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, patch, delete
}

protocol Requestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var bodyParams: [String : Any]? { get }
    var headers: [String : String]? { get }
}

extension Requestable {
    var method: HTTPMethod { return .get }
    var bodyParams: [String : Any]? { return nil }
    var headers: [String : String]? { return nil }
}
