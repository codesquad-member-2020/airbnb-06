//
//  Price.swift
//  Airbnb
//
//  Created by jinie on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct PriceDetail: Codable {
    
    let average: Double
    let prices: [Int]
    
    enum CodingKeys: String, CodingKey {
        case average = "avg"
        case prices = "priceDistribution"
    }
}
