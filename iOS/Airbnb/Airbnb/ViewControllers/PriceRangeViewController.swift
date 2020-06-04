//
//  PriceRangeViewController.swift
//  Airbnb
//
//  Created by jinie on 2020/06/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Alamofire

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
        
        requestPriceDetail()
        configureView()
        configureGraph()
        configureSlider()
    }
    
    override func viewDidLayoutSubviews() {
        slider.frame = CGRect(x: 0, y: 0, width: sliderView.bounds.width, height: sliderView.bounds.height)
    }
    
    private func requestPriceDetail() {
        let request = PriceDetailRequest()
        PriceUseCase(request: request, networkDispatcher: AF).perform(dataType: PriceDetail.self) { (priceDetail) in
            DispatchQueue.main.async {
                self.averageLabel.text = "일박 평균 가격은 \(Int(priceDetail.average))달러"
                self.graphView.priceDistribution = priceDetail.priceDistribution
                self.graphView.setNeedsDisplay()
            }
        }
    }
    
    private func configureView() {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        headerView.titleLabel.text = "가격"
    }
    
    private func configureGraph() {
        graphView.highlightLayer.priceRangeSlider = slider
    }
    
    private func configureSlider() {
        sliderView.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc func sliderValueChanged() {
        graphView.setNeedsDisplay()
    }
}
