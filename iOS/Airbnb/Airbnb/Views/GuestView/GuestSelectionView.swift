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
    @IBOutlet weak var minusButton: CountControlButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: CountControlButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        Bundle.main.loadNibNamed("GuestSelectionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}
