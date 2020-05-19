//
//  Accommodation.swift
//  Airbnb
//
//  Created by delma on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct Accommodation: Codable {
    var name: String
    var imageURLs: [String]
    var housingType: String
    var numBedrooms: Int
    var numBeds: Int
    var rating: String
    var numReviews: Int
    var isSuperHost: Bool
    var isFavorite: Bool
}
