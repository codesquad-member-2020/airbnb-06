//
//  SearchViewModel.swift
//  Airbnb
//
//  Created by delma on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class SearchViewModel: ViewModelBinding {
    typealias Key = FilteringCondition?
    typealias handler = (FilteringCondition?) -> Void
    private var changedHandler: handler
    private var filteringCondition: Key {
        didSet {
            changedHandler(filteringCondition)
        }
    }
    
    init(filteringCondition: FilteringCondition?, handler: @escaping handler) {
        self.filteringCondition = filteringCondition
        self.changedHandler = handler
        changedHandler(filteringCondition)
    }
    
    func updateNotify(changed handler: @escaping handler) {
        self.changedHandler = handler
    }
    
    func update(checkIn: String, checkOut: String) {
        filteringCondition?.checkIn = checkIn
        filteringCondition?.checkOut = checkOut
    }
    
    func update(minPrice: String, maxPrice: String) {
        filteringCondition?.minPrice = minPrice
        filteringCondition?.maxPrice = maxPrice
    }
    
    func update(guestCount: String) {
        filteringCondition?.guestCount = guestCount
    }
}
