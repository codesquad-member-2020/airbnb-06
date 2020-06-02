//
//  PriceRangeSliderTrackLayer.swift
//  Airbnb
//
//  Created by jinie on 2020/06/02.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeSliderTrackLayer: CALayer {

    weak var priceRangeSlider: PriceRangeSlider?
    
    override func draw(in ctx: CGContext) {
        guard let priceRangeSlider = priceRangeSlider else { return }
        
        let path = UIBezierPath(rect: bounds)
        let lowerValuePosition = priceRangeSlider.position(of: priceRangeSlider.lowerValue)
        let upperValuePosition = priceRangeSlider.position(of: priceRangeSlider.upperValue)
        let highlightedRect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        
        ctx.addPath(path.cgPath)
        ctx.setFillColor(priceRangeSlider.trackColor.cgColor)
        ctx.fillPath()
        
        ctx.setFillColor(priceRangeSlider.trackHighlightedColor.cgColor)
        ctx.fill(highlightedRect)
    }
}
