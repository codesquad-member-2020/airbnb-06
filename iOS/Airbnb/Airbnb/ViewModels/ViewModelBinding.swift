//
//  ViewModelBinding.swift
//  Airbnb
//
//  Created by delma on 2020/05/28.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Key
    func updateNotify(changed handler: @escaping (Key) -> Void)
}
