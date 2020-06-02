//
//  PriceRangeViewController.swift
//  Airbnb
//
//  Created by jinie on 2020/06/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: PopupHeaderView!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var graphView: PriceRangeGraphView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var footerView: PopupFooterView!
    
    private let slider = PriceRangeSlider(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSlider()
    }
    
    override func viewDidLayoutSubviews() {
        slider.frame = CGRect(x: 0, y: 0, width: sliderView.bounds.width, height: sliderView.bounds.height)
    }
    
    private func configureView() {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        headerView.titleLabel.text = "가격"
    }
    
    private func configureSlider() {
        sliderView.addSubview(slider)
    }
}
