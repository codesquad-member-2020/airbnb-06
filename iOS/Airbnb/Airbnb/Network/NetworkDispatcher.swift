//
//  NetworkDispatcher.swift
//  Airbnb
//
//  Created by delma on 2020/06/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func execute(request: URLRequest, handler: @escaping (Data?) -> Void)
    func implement(request: URLRequest, handler: @escaping (Int) -> Void)
}
