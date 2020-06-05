//
//  ImageUseCase.swift
//  Airbnb
//
//  Created by delma on 2020/06/05.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct NetworkUseCase {
      var request: URLRequest
      var networkDispatcher: NetworkDispatcher
      
      init(request: URLRequest, networkDispatcher: NetworkDispatcher) {
          self.request = request
          self.networkDispatcher = networkDispatcher
      }
    
    func perform(handler: @escaping (Data) -> ()) {
        networkDispatcher.execute(request: request) { anyData in
            guard let data = anyData else { return }
            handler(data)
        }
    }
}
