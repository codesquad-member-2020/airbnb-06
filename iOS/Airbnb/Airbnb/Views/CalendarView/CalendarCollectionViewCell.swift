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
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var rightBackground: UIView!
    @IBOutlet weak var leftBackground: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = ""
        circleView.hide()
        dateLabel.textColor = .black
        self.backgroundColor = .clear
        leftBackground.backgroundColor = .clear
        rightBackground.backgroundColor = .clear
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
    
    func changeBackground() {
        if dateLabel.text != "" {
            self.backgroundColor = UIColor(named: "LightGray")
        }
    }
    
    func configureLeftBackground() {
        leftBackground.backgroundColor = UIColor(named: "LightGray")
    }
    
    func configureRightBackground() {
        rightBackground.backgroundColor = UIColor(named: "LightGray")
    }
    
    func hideLeftBackground() {
        leftBackground.backgroundColor = .clear
    }
    
    func hideRightBackground() {
        rightBackground.backgroundColor = .clear
    }
}
