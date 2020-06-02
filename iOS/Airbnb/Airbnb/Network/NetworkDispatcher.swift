//
//  NetworkDispatcher.swift
//  Airbnb
//
//  Created by delma on 2020/06/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func execute(request: Request, handler: @escaping (Data?) -> Void)
}
