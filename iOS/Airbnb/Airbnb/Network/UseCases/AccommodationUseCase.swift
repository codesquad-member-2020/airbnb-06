//
//  AccommodationUseCase.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct AccommodationUseCase {
    var request: URLRequest
    var networkDispatcher: NetworkDispatcher
    
    init(request: URLRequest, networkDispatcher: NetworkDispatcher) {
        self.request = request
        self.networkDispatcher = networkDispatcher
    }
    
    func perform<T: Codable>(id: Int? = nil, dataType: T.Type, handler: @escaping (Any) -> Void) {
        networkDispatcher.execute(request: request) { anyData in
            guard let data = anyData else { return }
            guard let decodeData = try? JSONDecoder().decode(dataType, from: data) else { return }
            handler(decodeData)
        }
    }
    
    func perform(id: Int, handler: @escaping (Result<Any, NetworkError>) -> Void) {
        networkDispatcher.implement(request: request) { statusCode in
            switch statusCode {
            case 200...202:
                return handler(.success(true))
            default:
                return handler(.failure(.BadRequest))
            }
        }
    }
    
    func performMock(handler: @escaping (Any) -> Void) {
        AccommodationListMock().request { (decodeData) in
            handler(decodeData)
        }
    }
    
    func append(request: Queryable, name: QueryParameters, value: String) {
        request.append(name: name, value: value)
    }
}

