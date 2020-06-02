//
//  PriceRangeGraphHighlightLayer.swift
//  Airbnb
//
//  Created by jinie on 2020/06/02.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeGraphHighlightLayer: CALayer {
    
    weak var priceRangeSlider: PriceRangeSlider?
    
    override func draw(in ctx: CGContext) {
        guard let priceRangeSlider = priceRangeSlider else { return }
        
        let path = UIBezierPath(rect: bounds)
        let lowerValuePosition = priceRangeSlider.position(of: priceRangeSlider.lowerValue)
        let upperValuePosition = priceRangeSlider.position(of: priceRangeSlider.upperValue)
        let highlightedRect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        
        ctx.addPath(path.cgPath)
        ctx.setFillColor(UIColor(white: 0.9, alpha: 1.0).cgColor)
        ctx.fillPath()
        
        ctx.setFillColor(UIColor(white: 0.7, alpha: 1.0).cgColor)
        ctx.fill(highlightedRect)
    }
}
