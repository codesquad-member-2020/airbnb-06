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
        headerView.changeTitle("인원")
        
        adultSelectionView.changeAgeGroupLabel("성인")
        adultSelectionView.changeDetailLabel("만13세 이상")
        
        childSelectionView.changeAgeGroupLabel("청소년")
        childSelectionView.changeDetailLabel("만3세 ~ 만12세")
        
        infantSelectionView.changeAgeGroupLabel("영유아")
        infantSelectionView.changeDetailLabel("만2세 이하")
    }
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(close),
                                               name: NotificationName.closeButtonDidTouch,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(judgeGuestCount), name: .guestCount, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(completeSelection), name: .complete, object: nil)
    }
    
    @objc private func completeSelection() {
        dismiss(animated: true) {
            self.delegate?.send(text: "성인 \(self.adultSelectionView.selectedCount())명, 청소년 \(self.childSelectionView.selectedCount())명, 영유아\(self.infantSelectionView.selectedCount())명")
        }
    }
    
    @objc private func judgeGuestCount() {
        adultSelectionView.accordWithCondition() ? footerView.enableCompleteButton() : footerView.disableCompleteButton()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

extension Notification.Name {
    static let guestCount = Notification.Name("getCount")
}
