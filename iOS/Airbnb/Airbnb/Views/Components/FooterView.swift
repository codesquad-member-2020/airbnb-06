//
//  FooterView.swift
//  Airbnb
//
//  Created by jinie on 2020/05/21.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class FooterView: UIView {

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
        Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        completeButton.layer.cornerRadius = 5.0
        completeButton.layer.masksToBounds = true
    }

}
