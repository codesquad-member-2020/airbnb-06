//
//  CalendarCollectionViewCell.swift
//  Airbnb
//
//  Created by jinie on 2020/05/20.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var circleView: CircleView!
  
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(date: Int) {
        dateLabel.text = "\(date)"
    }
    
    func select() {
        circleView.show()
        dateLabel.textColor = .white
    }
    
    func deselect() {
        circleView.hide()
        dateLabel.textColor = .black
    }
}
