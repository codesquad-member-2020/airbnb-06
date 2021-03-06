//
//  AccommodationRequest.swift
//  Airbnb
//
//  Created by delma on 2020/05/28.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

enum AccommodationRequests {
    case detail
    case list
    case liked
    
    var request: Request {
        switch self {
        case .detail: return AccommodationRequest()
        case .list: return AccommodationListRequest()
        case .liked: return LikedAccommodationListRequest()
        }
    }
}

class AccommodationRequest: Request, URLRequestConvertible {
    var path: String = EndPoints.defaultURL + EndPoints.listings
    var method: HTTPMethod = .get
    var headers: HTTPHeaders?
    
    func append(id: Int) {
        path += "/\(id)"
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = self.method.rawValue
        guard let headersWithToken = setToken() else { return request }
        request.headers = headersWithToken
        return request
    }
}

final class AccommodationListRequest: AccommodationRequest, Queryable {
    var queryItems: [URLQueryItem] = []
    
    func append(name: QueryParameters, value: String) {
        let queryItem = URLQueryItem(name: name.description, value: value)
        queryItems.append(queryItem)
    }
    
    override func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = self.method.rawValue
        guard var urlComponents = URLComponents(string: path) else { return request }
        urlComponents.queryItems = queryItems
        guard let urlWithQuery = urlComponents.url else { return request}
        request.url = urlWithQuery
        guard let headersWithToken = setToken() else { return request }
        request.headers = headersWithToken
        return request
    }
}

final class LikedAccommodationListRequest: AccommodationRequest {
    override var method: HTTPMethod {
        get { return .patch }
        set { super.method = newValue }
    }
}
