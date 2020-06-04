//
//  AccommodationUseCase.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct AccommodationUseCase {
    var request: Request
    var networkDispatcher: NetworkDispatcher
    
    init(request: Request, networkDispatcher: NetworkDispatcher) {
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
    
    func performMock(handler: @escaping (Any) -> Void) {
        AccommodationListMock().request { (decodeData) in
            handler(decodeData)
        }
    }
    
    func append(request: Queryable, name: QueryParameters, value: String) {
        request.append(name: name, value: value)
    }
}

