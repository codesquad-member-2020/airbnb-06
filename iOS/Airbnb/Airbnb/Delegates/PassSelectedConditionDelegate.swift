//
//  SendDataDelegate.swift
//  Airbnb
//
//  Created by delma on 2020/05/30.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

protocol PassSelectedConditionDelegate {
    func date(checkIn: String, checkOut: String)
    func guest(count: String)
    func price(minimum: String, maximum: String)
}
