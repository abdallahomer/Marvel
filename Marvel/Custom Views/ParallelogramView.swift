//
//  ParallelogramView.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

@IBDesignable
class ParallelogramView: UILabel {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: bounds.minX + offset, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX - offset, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        
        path.close()
        fillColor.setFill()
        path.fill()
    }
    
    @IBInspectable var offset: CGFloat = 10.0 {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var fillColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }
}
