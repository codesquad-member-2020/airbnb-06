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
    
    @IBOutlet weak var filteringDescriptionLabel: SearchTextField!
    @IBOutlet weak var accommodationSearchCollectionView: AccommodationSearchCollectionView!
    @IBOutlet weak var floatingButton: Floaty!
    
    private var accommodationListViewModel: AccommodationListViewModel!
    private var accommodationSearchDataSource: AccommodationSearchCollectionViewDataSource!
    
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
    
    @IBAction func showCalendarViewController(_ sender: Any) {
        guard let calendarViewController = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else { return }
        calendarViewController.delegate = self
        show(calendarViewController)
    }
    
    @IBAction func showPriceRangeViewController(_ sender: FilterButton) {
        guard let priceRangeViewController = storyboard?.instantiateViewController(withIdentifier: "PriceRangeViewController") as? PriceRangeViewController else { return }
        show(priceRangeViewController)
    }
    
    private func show(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
    
    func changeFilteringDescription(_ text: String) {
        filteringDescriptionLabel.text = text
    }
}

extension SearchViewController: SendDataDelegate {
    func send(text: String) {
        changeFilteringDescription(text)
    }
}
