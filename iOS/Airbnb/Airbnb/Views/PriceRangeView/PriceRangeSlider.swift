//
//  PriceRangeSlider.swift
//  Airbnb
//
//  Created by jinie on 2020/06/02.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeSlider: UIControl {
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    var minimumValue: CGFloat = 0.0
    var maximumValue: CGFloat = 1.0
    var lowerValue: CGFloat = 0.0
    var upperValue: CGFloat = 1.0
    var previousLocation = CGPoint()
    
    let trackLayer = PriceRangeSliderTrackLayer()
    let lowerThumbLayer = PriceRangeSliderThumbLayer()
    let upperThumbLayer = PriceRangeSliderThumbLayer()
    
    var trackColor = UIColor(white: 0.9, alpha: 1.0)
    var trackHighlightedColor = UIColor(white: 0.7, alpha: 1.0)
    var thumbColor = UIColor.white
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.priceRangeSlider = self
        lowerThumbLayer.priceRangeSlider = self
        upperThumbLayer.priceRangeSlider = self
        
        layer.addSublayer(trackLayer)
        layer.addSublayer(lowerThumbLayer)
        layer.addSublayer(upperThumbLayer)
        
        updateLayerFrames()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: 12.5)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = position(of: lowerValue)
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = position(of: upperValue)
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    
    func position(of value: CGFloat) -> CGFloat {
        return bounds.width * CGFloat(value)
    }
}

extension PriceRangeSlider {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.isHighlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.isHighlighted = true
        }
        
        return lowerThumbLayer.isHighlighted || upperThumbLayer.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let currentLocation = touch.location(in: self)
        let draggedValue = (currentLocation.x - previousLocation.x) / bounds.width
        previousLocation = currentLocation
        
        if lowerThumbLayer.isHighlighted {
            lowerValue += draggedValue
            lowerValue = max(lowerValue, minimumValue)
        } else if upperThumbLayer.isHighlighted {
            upperValue += draggedValue
            upperValue = min(upperValue, maximumValue)
        }
        
        updateLayerFrames()
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.isHighlighted = false
        upperThumbLayer.isHighlighted = false
    }
}
