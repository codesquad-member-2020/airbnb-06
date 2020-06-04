//
//  PriceRequest.swift
//  Airbnb
//
//  Created by jinie on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

final class PriceDetailRequest: Request, URLRequestConvertible {

    var path: String = EndPoints.defaultURL + EndPoints.priceGraph
    var headers: HTTPHeaders?
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        guard let headersWithToken = setToken() else { return request }
        request.headers = headersWithToken
        return request
    }
}
