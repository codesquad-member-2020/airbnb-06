//
//  AccommodationUseCase.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

struct AccommodationUseCase {
    var request: URLRequestConvertible
    
    init(request: URLRequestConvertible) {
        self.request = request
    }
    
    func perform<T: Codable>(id: Int? = nil, dataType: T.Type, handler: @escaping (Any) -> Void) {
        AF.request(request).responseJSON { response in
            guard let data = response.data, response.error != nil else { return }
            guard let decodeData = try? JSONDecoder().decode(dataType, from: data) else { return }
            handler(decodeData)
        }
    }
    
    func append(request: Queryable, name: QueryParameters, value: String) {
        request.append(name: name, value: value)
    }
}

