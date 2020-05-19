//
//  SearchTextField.swift
//  Airbnb
//
//  Created by delma on 2020/05/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        self.layer.backgroundColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.size.height / 2

        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.white.cgColor

        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        self.layer.shadowColor = UIColor.lightGray.cgColor

    }
}

