//
//  PriceRangeGraphHighlightLayer.swift
//  Airbnb
//
//  Created by jinie on 2020/06/02.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeGraphHighlightLayer: CALayer {
    
    override func draw(in ctx: CGContext) {
        let path = UIBezierPath(rect: bounds)
        
        ctx.addPath(path.cgPath)
        ctx.setFillColor(UIColor(white: 0.9, alpha: 1.0).cgColor)
        ctx.fillPath()
        
        ctx.setFillColor(UIColor(white: 0.7, alpha: 1.0).cgColor)
        ctx.fill(CGRect(x: 100.0, y: 0.0, width: 100.0, height: bounds.height))
    }
}
