//
//  EndPoints.swift
//  Airbnb
//
//  Created by delma on 2020/05/27.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

enum EndPoints {
    static let defaultURL = "http://52.78.203.80/api/"
    static let login = "login"
    static let listings = "listings"
    static let bookings = "bookings"
    static let map = "map"
    static let priceGraph = "price-graph"
}

enum QueryParameters: CustomStringConvertible {
    case checkIn
    case checkOut
    case numGuests
    case numPrice
    case maxPrice
    case offset
    case limit
    
    var description: String{
        switch self {
        case .checkIn: return "checkIn"
        case .checkOut: return "checkOut"
        case .numGuests: return "numGuests"
        case .numPrice: return "numPrice"
        case .maxPrice: return "maxPrice"
        case .offset: return "offset"
        case .limit: return "limit"
        }
    }
}
