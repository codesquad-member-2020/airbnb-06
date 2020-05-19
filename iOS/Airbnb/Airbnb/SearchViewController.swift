//
//  SearchViewController.swift
//  Airbnb
//
//  Created by delma on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Floaty

class SearchViewController: UIViewController {
    
    @IBOutlet var filteringDescriptionLabel: SearchTextField!
    @IBOutlet var accommodationSearchCollectionView: AccommodationSearchCollectionView!
    private var accommodationSearchDataSource: AccommodationSearchCollectionViewDataSource!
    @IBOutlet var floatingButton: Floaty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
