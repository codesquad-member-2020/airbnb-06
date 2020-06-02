//
//  GuestViewController.swift
//  Airbnb
//
//  Created by jinie on 2020/05/25.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: PopupHeaderView!
    @IBOutlet weak var adultSelectionView: GuestSelectionView!
    @IBOutlet weak var childSelectionView: GuestSelectionView!
    @IBOutlet weak var infantSelectionView: GuestSelectionView!
    @IBOutlet weak var footerView: PopupFooterView!
    
    var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerNotification()
    }
    
    private func configureView() {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        headerView.changeTitle(GuestSelectionViewModel.personCountText)
        
        adultSelectionView.changeAgeGroupLabel(GuestSelectionViewModel.adultText)
        adultSelectionView.changeDetailLabel(GuestSelectionViewModel.adultRangeText)
        
        childSelectionView.changeAgeGroupLabel(GuestSelectionViewModel.childText)
        childSelectionView.changeDetailLabel(GuestSelectionViewModel.childRangeText)
        
        infantSelectionView.changeAgeGroupLabel(GuestSelectionViewModel.infantText)
        infantSelectionView.changeDetailLabel(GuestSelectionViewModel.infantRangeText)
    }
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(close),
                                               name: NotificationName.closeButtonDidTouch,
                                               object: nil)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
