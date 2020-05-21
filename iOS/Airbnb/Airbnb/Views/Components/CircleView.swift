//
//  CircleView.swift
//  Airbnb
//
//  Created by delma on 2020/05/20.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        self.layer.cornerRadius = self.frame.height / 2 + self.frame.height / 10
        self.clipsToBounds = true
        self.backgroundColor = .black
        self.alpha = 0.0
    }
    
    func show() {
        self.alpha = 1.0
    }
    
    func hide() {
        self.alpha = 0.0
    }
}

