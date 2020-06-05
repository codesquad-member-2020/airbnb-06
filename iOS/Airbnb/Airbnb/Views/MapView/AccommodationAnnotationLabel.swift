//
//  AccommodationAnnotationLabel.swift
//  Airbnb
//
//  Created by jinie on 2020/06/05.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class AccommodationAnnotationLabel: UILabel {
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height / 2
            clipsToBounds = true
        }
    }
    
    let insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
    init() {
        super.init(frame: .zero)
        
        textColor = .white
        font = .systemFont(ofSize: 15, weight: .semibold)
        backgroundColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insets.left + insets.right,
                      height: size.height + insets.top + insets.bottom)
    }
}
