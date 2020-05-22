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
    
    @IBOutlet weak var dateFilterButton: FilterButton!
    @IBOutlet weak var guestFilterButton: FilterButton!
    @IBOutlet weak var priceFilterButton: FilterButton!
    @IBOutlet weak var filteringDescriptionLabel: SearchTextField!
    @IBOutlet weak var accommodationSearchCollectionView: AccommodationSearchCollectionView!
    @IBOutlet weak var floatingButton: Floaty!
    
    private var accommodationSearchDataSource: AccommodationSearchCollectionViewDataSource!
    
    @IBAction func displayFilter(_ sender: FilterButton) {
        let calendarViewController = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        calendarViewController.modalPresentationStyle = .overCurrentContext
        calendarViewController.modalTransitionStyle = .crossDissolve
        present(calendarViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
