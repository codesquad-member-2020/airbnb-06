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
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var graphView: PriceRangeGraphView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var footerView: PopupFooterView!
    
    private let slider = PriceRangeSlider(frame: .zero)
    var delegate: PassSelectedConditionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotification()
        requestPriceDetail()
        configureView()
        configureGraph()
        configureSlider()
    }
    
    override func viewDidLayoutSubviews() {
        slider.frame = CGRect(x: 0, y: 0, width: sliderView.bounds.width, height: sliderView.bounds.height)
    }
    
    private func requestPriceDetail() {
        let request = PriceDetailRequest().asURLRequest()
        PriceUseCase(request: request, networkDispatcher: AF).perform(dataType: PriceDetail.self) { (priceDetail) in
            DispatchQueue.main.async {
                self.averageLabel.text = "일박 평균 가격은 \(Int(priceDetail.average))달러"
                self.graphView.priceDistribution = priceDetail.priceDistribution
                self.graphView.setNeedsDisplay()
            }
        }
    }
    private func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(close),
                                               name: NotificationName.closeButtonDidTouch,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(completeSelection), name: .complete, object: nil)
    }
    
    @objc private func completeSelection() {
        dismiss(animated: true) {
            self.delegate?.price(minimum: self.changeRangeLabel().minimum, maximum: self.changeRangeLabel().maximum)
        }
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
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
        changeRangeLabel()
        graphView.setNeedsDisplay()
    }
    
    private func changeRangeLabel() -> (minimum: String, maximum: String){
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let lowerPrice = numberFormatter.string(from: NSNumber(value: Int(slider.lowerValue * 1000)))!
        let upperPrice = numberFormatter.string(from: NSNumber(value: Int(slider.upperValue * 1000)))!
        rangeLabel.text = "$\(lowerPrice) - $\(upperPrice)"
        self.footerView.enableCompleteButton()
        return (minimum: lowerPrice, maximum: upperPrice)
    }
}

