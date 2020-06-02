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
    func execute(request: Request, handler: @escaping (Data?) -> Void) {
        self.request(request as! URLRequestConvertible).validate().response { response in
            handler(response.data)
        }
    }
}
