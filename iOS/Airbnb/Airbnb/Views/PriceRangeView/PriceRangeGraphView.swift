//
//  PriceRangeGraphView.swift
//  Airbnb
//
//  Created by jinie on 2020/06/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class PriceRangeGraphView: UIView {
    
    var data: [CGFloat] = [0, 0, 0, 0, 0, 2, 5, 4, 13, 10, 14, 11, 16, 14, 20, 15, 13, 10, 8, 6, 7, 6, 4, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let highlightLayer = PriceRangeGraphHighlightLayer()
    
    override func draw(_ rect: CGRect) {
        let path = curvedPath()
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.addSublayer(highlightLayer)
        highlightLayer.mask = mask
        highlightLayer.frame = bounds
        highlightLayer.setNeedsDisplay()
    }
    
    func curvedPath() -> UIBezierPath {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data.count - 1)
        var point1 = CGPoint(x: 0, y: yCoordinate(index: 0))
        var oldControlPoint: CGPoint?
        
        path.move(to: point1)
        
        for index in 1..<data.count {
            let point2 = CGPoint(x: step * CGFloat(index), y: yCoordinate(index: index))
            var point3: CGPoint?
            
            if index < data.count - 1 {
                point3 = CGPoint(x: step * CGFloat(index + 1), y: yCoordinate(index: index + 1))
            }
            
            let newControlPoint = controlPoint(point1: point1, point2: point2, next: point3)
            path.addCurve(to: point2, controlPoint1: oldControlPoint ?? point1, controlPoint2: newControlPoint ?? point2)
            oldControlPoint = oppositePoint(point: newControlPoint, center: point2)
            point1 = point2
        }
        
        return path
    }
    
    func yCoordinate(index: Int) -> CGFloat {
        return bounds.height - bounds.height * data[index] / (data.max() ?? 0)
    }
    
    func controlPoint(point1: CGPoint, point2: CGPoint, next point3: CGPoint?) -> CGPoint? {
        guard let point3 = point3 else { return nil }
        
        let leftMidPoint  = midPoint(point1: point1, point2: point2)
        let rightMidPoint = midPoint(point1: point2, point2: point3)
        var controlPoint = midPoint(point1: leftMidPoint, point2: oppositePoint(point: rightMidPoint, center: point2)!)
        let oppositeOfControlPoint = oppositePoint(point: controlPoint, center: point2)!
        
        if point1.y.between(a: point2.y, b: controlPoint.y) {
            controlPoint.y = point1.y
        } else if point2.y.between(a: point1.y, b: controlPoint.y) {
            controlPoint.y = point2.y
        } else if point2.y.between(a: point3.y, b: oppositeOfControlPoint.y) {
            controlPoint.y = point2.y
        } else if point3.y.between(a: point2.y, b: oppositeOfControlPoint.y) {
            let diffY = abs(point2.y - point3.y)
            controlPoint.y = point2.y + diffY * (point3.y < point2.y ? 1 : -1)
        }
        
        controlPoint.x += (point2.x - point1.x) * 0.1
        
        return controlPoint
    }
    
    func midPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    func oppositePoint(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let point = point, let center = center else { return nil }
        
        let newX = 2 * center.x - point.x
        let diffY = abs(point.y - center.y)
        let newY = center.y + diffY * (point.y < center.y ? 1 : -1)
        
        return CGPoint(x: newX, y: newY)
    }
}

extension CGFloat {
    
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}
