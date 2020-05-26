//
//  HeaderView.swift
//  Airbnb
//
//  Created by jinie on 2020/05/21.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

}
