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
    
    private var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "LightGray")
        return view
    }()
    
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
        background.isHidden = true
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
    
    func checkInBackground() {
        configureBackground()
        background.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
    
    func checkOutBackground() {
        configureBackground()
        background.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    func removeBackground() {
        background.removeFromSuperview()
    }
    
    private func configureBackground() {
        background.isHidden = false
        self.contentView.insertSubview(background, belowSubview: circleView)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
