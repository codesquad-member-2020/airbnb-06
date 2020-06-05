//
//  Accommodation.swift
//  Airbnb
//
//  Created by delma on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct Accommodation: Codable {
    var id: Int
    var name: String
    var imageUrls: [String]
    var housingType: String
    var numBedrooms: Int
    var numBeds: Int
    var rating: Double
    var numReviews: Int
    var isSuperHost: Bool
    var isBookmarked: Bool
    var latitude: Double
    var longitude: Double
    var price: Double
}
