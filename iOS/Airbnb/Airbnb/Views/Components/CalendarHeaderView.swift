//
//  CalendarHeaderView.swift
//  Airbnb
//
//  Created by delma on 2020/05/21.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class CalendarHeaderView: UICollectionReusableView {

    @IBOutlet var yearMonthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(_ text: String) {
        yearMonthLabel.text = text
    }
}
