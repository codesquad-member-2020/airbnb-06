//
//  SearchViewController.swift
//  Airbnb
//
//  Created by delma on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var filteringDescriptionLabel: UILabel!
    @IBOutlet var accommodationSearchCollectionView: AccommodationSearchCollectionView!
    private var accommodationSearchDataSource: AccommodationSearchCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
