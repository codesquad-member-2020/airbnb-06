//
//  BookMarkedCollectionViewDataSource.swift
//  Airbnb
//
//  Created by delma on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class BookMarkedCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var accommodations: [Accommodation]
    
    init(accommodations: [Accommodation]) {
        self.accommodations = accommodations
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accommodations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccommodationSearchCollectionViewCell", for: indexPath) as! AccommodationSearchCollectionViewCell
        cell.configureData(accommodations[indexPath.row])
        return cell
    }
}
