//
//  CountControlButton.swift
//  Airbnb
//
//  Created by jinie on 2020/05/25.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class CountControlButton: UIButton {
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.width / 2
            layer.masksToBounds = true
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    func configure() {
        tintColor = .darkGray
        imageEdgeInsets = UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
    }
}
