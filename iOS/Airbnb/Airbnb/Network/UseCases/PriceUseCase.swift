//
//  PriceUseCase.swift
//  Airbnb
//
//  Created by jinie on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct PriceUseCase {
    
    var request: Request
    var networkDispatcher: NetworkDispatcher
    
    init(request: Request, networkDispatcher: NetworkDispatcher) {
        self.request = request
        self.networkDispatcher = networkDispatcher
    }
    
    func perform<T: Codable>(dataType: T.Type, handler: @escaping (T) -> ()) {
        networkDispatcher.execute(request: request) { (data) in
            guard let data = data else { return }
            guard let decodedData = try? JSONDecoder().decode(dataType, from: data) else { return }
            handler(decodedData)
        }
    }
}
