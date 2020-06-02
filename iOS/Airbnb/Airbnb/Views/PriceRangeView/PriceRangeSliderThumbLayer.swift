//
//  PriceRangeSliderThumbLayer.swift
//  Airbnb
//
//  Created by jinie on 2020/06/02.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeSliderThumbLayer: CALayer {

    weak var priceRangeSlider: PriceRangeSlider?
    var highlighted = false
    
    override func draw(in ctx: CGContext) {
        guard let priceRangeSlider = priceRangeSlider else { return }
        
        let thumbFrame = bounds.insetBy(dx: 1.0, dy: 1.0)
        let cornerRadius = thumbFrame.height / 2.0
        let path = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
        
        ctx.addPath(path.cgPath)
        ctx.setFillColor(priceRangeSlider.thumbColor.cgColor)
        ctx.fillPath()
        
        ctx.addPath(path.cgPath)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.strokePath()
    }
}
