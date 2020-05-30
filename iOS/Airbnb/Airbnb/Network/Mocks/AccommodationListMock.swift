//
//  AccommodationListMock.swift
//  Airbnb
//
//  Created by delma on 2020/05/28.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct AccommodationListMock {
    func request(handler: @escaping ([Accommodation]) -> Void) {
        guard let path = Bundle.main.path(forResource: "FakeAccommodationList", ofType: "json") else { return }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decodedData = try JSONDecoder().decode([Accommodation].self, from: data)
            handler(decodedData)
        } catch {
            print(error.localizedDescription)
        }
    }
}
