//
//  AccommodationListViewModel.swift
//  Airbnb
//
//  Created by delma on 2020/05/28.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class AccommodationListViewModel: ViewModelBinding {
    typealias Key = [Accommodation]
    typealias handler = ([Accommodation]) -> Void
    private var changedHandler: handler
    private var accommodation: Key {
        didSet {
            changedHandler(accommodation)
        }
    }
    
    init(accommodation: [Accommodation], handler: @escaping handler) {
        self.accommodation = accommodation
        self.changedHandler = handler
        changedHandler(accommodation)
    }
    
    func updateNotify(changed handler: @escaping ([Accommodation]) -> Void) {
        self.changedHandler = handler
    }
}
