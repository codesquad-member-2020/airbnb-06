//
//  SearchViewController.swift
//  Airbnb
//
//  Created by delma on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Floaty
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var dateSelectionButton: FilterButton!
    @IBOutlet weak var guestSelectionButton: FilterButton!
    @IBOutlet weak var priceSelectionButton: FilterButton!
    @IBOutlet weak var filteringDescriptionLabel: SearchTextField!
    @IBOutlet weak var accommodationSearchCollectionView: AccommodationSearchCollectionView!
    @IBOutlet weak var floatingButton: Floaty!
    
    private var accommodationListViewModel: AccommodationListViewModel!
    private var accommodationSearchDataSource: AccommodationSearchCollectionViewDataSource!
    private var searchViewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        collectionViewConfigure()
        requestAccommodationList()
        configureObservers()
        searchViewModel = SearchViewModel(filteringCondition: FilteringCondition(), handler: { filteringCondition in
            self.makeFilteringRequest(filteringCondition)
        })
    }
    
    @IBAction func showCalendarViewController(_ sender: Any) {
        guard let calendarViewController = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else { return }
        calendarViewController.delegate = self
        show(calendarViewController)
    }
    
    @IBAction func showGuestViewController(_ sender: FilterButton) {
        guard let guestViewController = storyboard?.instantiateViewController(withIdentifier: "GuestViewController") as? GuestViewController else { return }
        guestViewController.delegate = self
        show(guestViewController)
    }
    
    @IBAction func showPriceRangeViewController(_ sender: FilterButton) {
        guard let priceRangeViewController = storyboard?.instantiateViewController(withIdentifier: "PriceRangeViewController") as? PriceRangeViewController else { return }
        show(priceRangeViewController)
    }
    
    @IBAction func showMapViewController(_ sender: Floaty) {
        guard let mapViewController = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        mapViewController.modalPresentationStyle = .fullScreen
        present(mapViewController, animated: true, completion: nil)
    }
    
    private func show(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }
    
    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(requestAccommodationBookmark(_:)), name: .bookmark, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorAlert(_:)), name: .showErrorAlert, object: nil)
    }
    
    @objc private func showErrorAlert(_ notification: Notification) {
        guard let error = notification.userInfo?["error"] as? Error else { return }
        let errorAlert = ErrorAlertController()
        errorAlert.set(message: error as! NetworkError)
        errorAlert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(errorAlert, animated: true)
    }
    
    private func collectionViewConfigure() {
        accommodationSearchCollectionView.register(UINib(nibName: "AccommodationSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AccommodationSearchCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 40, height: self.view.frame.height / 3)
        layout.scrollDirection = .vertical
        accommodationSearchCollectionView.collectionViewLayout = layout
        accommodationSearchCollectionView.showsVerticalScrollIndicator = false
    }
    
    private func requestAccommodationList() {
        let request = AccommodationRequests<AccommodationRequest>.list.request.asURLRequest()
        AccommodationUseCase(request: request, networkDispatcher: AF).perform(dataType: [Accommodation].self) { accommodationList in
            self.accommodationListViewModel = AccommodationListViewModel(accommodation: accommodationList as! [Accommodation], handler: { accommodations in
                DispatchQueue.main.async {
                    self.accommodationSearchDataSource = AccommodationSearchCollectionViewDataSource(accommodations: accommodations)
                    self.accommodationSearchCollectionView.dataSource = self.accommodationSearchDataSource
                    self.accommodationSearchCollectionView.reloadData()
                }
            })
        }
    }
    
    @objc private func requestAccommodationBookmark(_ notification: Notification) {
        guard let id = notification.userInfo?["id"] as? Int else { return }
        let likeRequest = AccommodationRequests<AccommodationLikedRequest>.liked.request
        likeRequest.append(id: id)
        let request = likeRequest.asURLRequest()
        AccommodationUseCase(request: request, networkDispatcher: AF).perform(id: id) { result in
            switch result {
            case .success(let isBookmarked):
                break
            case .failure(let error):
                let errorAlert = ErrorAlertController()
                errorAlert.set(message: error)
                errorAlert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(errorAlert, animated: true)
            }
        }
    }
    
    private func filteringAccommodation(listRequest: AccommodationListRequest) {
        let request = listRequest.asURLRequest()
        AccommodationUseCase(request: request, networkDispatcher: AF).perform(dataType: [Accommodation].self) { accommodationList in
            self.accommodationListViewModel = AccommodationListViewModel(accommodation: accommodationList as! [Accommodation], handler: { accommodations in
                DispatchQueue.main.async {
                    self.accommodationSearchDataSource = AccommodationSearchCollectionViewDataSource(accommodations: accommodations)
                    self.accommodationSearchCollectionView.dataSource = self.accommodationSearchDataSource
                    self.accommodationSearchCollectionView.reloadData()
                }
            })
        }
    }
    
    private func makeFilteringRequest(_ filteringCondition: FilteringCondition?) {
        let listRequest = AccommodationRequests<AccommodationListRequest>.list.request
        
        if let checkIn = filteringCondition?.checkIn, let checkOut = filteringCondition?.checkOut {
            listRequest.append(name: .checkIn, value: checkIn)
            listRequest.append(name: .checkOut, value: checkOut)
        }
        
        if let guestCount = filteringCondition?.guestCount {
            listRequest.append(name: .numGuests, value: guestCount)
        }
        
        if let minPrice = filteringCondition?.minPrice, let maxPrice = filteringCondition?.maxPrice {
            listRequest.append(name: .minPrice, value: minPrice)
            listRequest.append(name: .maxPrice, value: maxPrice)
        }
        
        if let searchText = filteringCondition?.query {
            listRequest.append(name: .query, value: searchText)
        }
        
        self.filteringAccommodation(listRequest: listRequest)
    }
}

extension SearchViewController: PassSelectedConditionDelegate {
    func date(checkIn: String, checkOut: String) {
        updateSearchViewModelDate(checkIn: checkIn, checkOut: checkOut)
        let start = checkIn.index(checkIn.startIndex, offsetBy: 5)
        let end = checkIn.index(checkIn.endIndex, offsetBy: -1)
        dateSelectionButton.configureTitle("\(checkIn[start...end]) ~ \(checkOut[start...end])")
        filteringDescriptionLabel.isHidden = true
    }
    
    func guest(count: String) {
        updateSearchViewModelGuest(count: count)
        guestSelectionButton.configureTitle("\(count)명")
        filteringDescriptionLabel.isHidden = true
    }
    
    func price(minimum: String, maximum: String) {
        updateSearchViewModelPrice(minimum: minimum, maximum: maximum)
        priceSelectionButton.configureTitle("\(minimum)원 ~ \(maximum)원")
        filteringDescriptionLabel.isHidden = true
    }
    
    private func updateSearchViewModelDate(checkIn: String, checkOut: String) {
        searchViewModel.update(checkIn: checkIn, checkOut: checkOut)
    }
    
    private func updateSearchViewModelGuest(count: String) {
        searchViewModel.update(guestCount: count)
    }
    
    private func updateSearchViewModelPrice(minimum: String, maximum: String) {
        searchViewModel.update(minPrice: minimum, maxPrice: maximum)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text, searchText != "" {
            updateSearchViewModelQuery(searchText: searchText)
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    private func updateSearchViewModelQuery(searchText: String) {
        searchViewModel.update(searchText: searchText)
    }
}

extension Notification.Name {
    static let bookmark = Notification.Name("bookmark")
    static let showErrorAlert = Notification.Name("showErrorAlert")
}
