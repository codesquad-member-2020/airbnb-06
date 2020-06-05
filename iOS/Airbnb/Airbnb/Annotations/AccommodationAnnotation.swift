//
//  AccommodationAnnotation.swift
//  Airbnb
//
//  Created by jinie on 2020/06/05.
//  Copyright © 2020 jinie. All rights reserved.
//

import MapKit

class AccommodationAnnotation: NSObject, MKAnnotation {
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var price: Double
    
    init(coordinate: CLLocationCoordinate2D, price: Double) {
        self.coordinate = coordinate
        self.price = price
        super.init()
    }
}
