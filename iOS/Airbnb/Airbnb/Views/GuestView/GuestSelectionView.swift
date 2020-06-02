//
//  GuestSelectionView.swift
//  Airbnb
//
//  Created by jinie on 2020/05/25.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class GuestSelectionView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ageGroupLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: CountControlButton!
    @IBOutlet weak var minusButton: CountControlButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed("GuestSelectionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        configureButton()
    }
    
    private func configureButton() {
        plusButton.addTarget(self, action: #selector(addCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(subtractCount), for: .touchUpInside)
    }
    
    @objc private func addCount() {
        let count = Int(countLabel.text!)!
        guard count < 8  else { return }
        countLabel.text = "\(count + 1)"
    }
    
    @objc private func subtractCount() {
        let count = Int(countLabel.text!)!
        guard count > 0  else { return }
        countLabel.text = "\(count - 1)"
    }

    func changeAgeGroupLabel(_ text: String) {
        ageGroupLabel.text = text
    }
    
    func changeDetailLabel(_ text: String) {
        detailLabel.text = text
    }
}
