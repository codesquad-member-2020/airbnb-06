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
    
    private var accommodationListViewModel: AccommodationListViewModel!
    private var accommodationSearchDataSource: AccommodationSearchCollectionViewDataSource!
    private let identifiers: [String : String] = ["날짜": "CalendarViewController",
                                                  "인원": "GuestViewController",
                                                  "가격": "PriceViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
        requestMockList()
    }
    
    private func collectionViewConfigure() {
        accommodationSearchCollectionView.register(UINib(nibName: "AccommodationSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AccommodationSearchCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 40, height: self.view.frame.height / 3)
        layout.scrollDirection = .vertical
        accommodationSearchCollectionView.collectionViewLayout = layout
        accommodationSearchCollectionView.showsVerticalScrollIndicator = false
    }
    
    @IBAction func displayPopup(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: identifiers[title]!) else { return }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
    
    private func requestMockList() {
        AccommodationListMock().request { accommodationList in
            self.accommodationListViewModel = AccommodationListViewModel(accommodation: accommodationList, handler: { accommodations in
                DispatchQueue.main.async {
                    self.accommodationSearchDataSource = AccommodationSearchCollectionViewDataSource(accommodations: accommodations)
                    self.accommodationSearchCollectionView.dataSource = self.accommodationSearchDataSource
                    self.accommodationSearchCollectionView.reloadData()
                }
            })
        }
    }
}
