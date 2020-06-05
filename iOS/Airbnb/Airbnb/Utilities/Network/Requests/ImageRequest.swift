//
//  ImageRequest.swift
//  Airbnb
//
//  Created by delma on 2020/06/05.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

class ImageRequest: Request, URLRequestConvertible {
    var path: String
    var method: HTTPMethod = .GET
    
    init(path: String) {
        self.path = path
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = self.method.rawValue
        guard let headersWithToken = setToken() else { return request }
        request.headers = headersWithToken
        return request
    }
}
