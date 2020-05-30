//
//  FooterView.swift
//  Airbnb
//
//  Created by jinie on 2020/05/21.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PopupFooterView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        Bundle.main.loadNibNamed("PopupFooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        completeButton.layer.cornerRadius = 5.0
        completeButton.layer.masksToBounds = true
        completeButton.isEnabled = false
    }

    @IBAction func complete(_ sender: Any) {
        NotificationCenter.default.post(name: .complete, object: nil)
    }
    
    @IBAction func reset(_ sender: Any) {
        NotificationCenter.default.post(name: .reset, object: nil)
    }
    
    func enableCompleteButton() {
        completeButton.isEnabled = true
        completeButton.backgroundColor = UIColor(named: "MainColor")
    }
    
    func disableCompleteButton() {
        completeButton.isEnabled = false
        completeButton.backgroundColor = .black
    }
}

extension Notification.Name {
    static let reset = Notification.Name("reset")
    static let complete = Notification.Name("complete")
}
