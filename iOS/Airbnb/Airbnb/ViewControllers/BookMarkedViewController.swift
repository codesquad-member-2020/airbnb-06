//
//  BookMarkedViewController.swift
//  Airbnb
//
//  Created by delma on 2020/06/04.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Alamofire

class BookMarkedViewController: UIViewController {
    
    @IBOutlet weak var bookMarkedCollectionView: AccommodationSearchCollectionView!
    
    private var bookMarkedDataSource: BookMarkedCollectionViewDataSource!
    private var accommodationViewModel: AccommodationListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestBookMarkedAccommodations()
        
    }
    
    private func collectionViewConfigure() {
        bookMarkedCollectionView.register(UINib(nibName: "AccommodationSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AccommodationSearchCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 40, height: self.view.frame.height / 3)
        layout.scrollDirection = .vertical
        bookMarkedCollectionView.collectionViewLayout = layout
        bookMarkedCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func requestBookMarkedAccommodations() {
        let request = AccommodationRequests<AccommodationLikedListRequest>.likedList.request.asURLRequest()
        AccommodationUseCase(request: request, networkDispatcher: AF).perform(dataType: [Accommodation].self) { accommodation in
            self.accommodationViewModel = AccommodationListViewModel(accommodation: accommodation as! [Accommodation], handler: { accommodations in
                DispatchQueue.main.async {
                    self.bookMarkedDataSource = BookMarkedCollectionViewDataSource(accommodations: accommodations)
                    self.bookMarkedCollectionView.dataSource = self.bookMarkedDataSource
                    self.bookMarkedCollectionView.reloadData()
                }
            })
        }
    }
}
