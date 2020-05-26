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
    private let identifiers: [String : String] = ["날짜": "CalendarViewController",
                                                  "인원": "GuestViewController",
                                                  "가격": "PriceViewController"]
    
    @IBAction func displayPopup(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: identifiers[title]!) else { return }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
