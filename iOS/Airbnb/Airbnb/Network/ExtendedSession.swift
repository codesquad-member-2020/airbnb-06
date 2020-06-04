//
//  ExtendedSession.swift
//  Airbnb
//
//  Created by delma on 2020/06/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation
import Alamofire

extension Session: NetworkDispatcher {
    func execute(request: URLRequest, handler: @escaping (Data?) -> Void) {
        self.request(request).validate().response { response in
            handler(response.data)
        }
    }
    
    func implement(request: URLRequest, handler: @escaping (Int) -> Void) {
        self.request(request).validate().response { response in
            guard let statusCode = response.response?.statusCode else { return }
            handler(statusCode)
        }
    }
}
