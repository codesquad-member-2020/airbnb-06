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
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func close(_ sender: UIButton) {
        NotificationCenter.default.post(name: NotificationName.closeButtonDidTouch, object: nil)
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
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

}

enum NotificationName {
    static let closeButtonDidTouch = Notification.Name("closeButtonDidTouch")
}
