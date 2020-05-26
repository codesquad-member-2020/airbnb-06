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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerNotification()
    }
    
    private func configureView() {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        headerView.titleLabel.text = "인원"
        adultSelectionView.ageGroupLabel.text = "성인"
        adultSelectionView.detailLabel.text = "만13세 이상"
        childSelectionView.ageGroupLabel.text = "청소년"
        childSelectionView.detailLabel.text = "만3세 ~ 만12세"
        infantSelectionView.ageGroupLabel.text = "영유아"
        infantSelectionView.detailLabel.text = "만2세 이하"
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
