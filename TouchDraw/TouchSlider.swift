//
//  TouchSlider.swift
//  CustomSlider
//
//  Created by Joe E. on 10/2/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

@IBDesignable
class TouchSlider: UIView {
    
    @IBInspectable var barColor: UIColor = UIColor.blackColor()
    @IBInspectable var circleColor: UIColor = UIColor.whiteColor()
    @IBInspectable var value: CGFloat = 0 {
        didSet {
            if value < minValue { value = minValue }
            if value > maxValue { value = maxValue }
            
            setNeedsDisplay() // this resets the drawing everytime the value changes
            
        }
        
    }

    @IBInspectable var minValue: CGFloat = 0
    @IBInspectable var maxValue: CGFloat = 100
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        barColor.set()
        CGContextMoveToPoint(context, 0, rect.height / 2)
        CGContextAddLineToPoint(context, rect.width, rect.height / 2)
        
        CGContextStrokePath(context)
        
        CGContextAddEllipseInRect(context, handleRect)
        
        CGContextStrokePath(context)
        CGContextFillEllipseInRect(context, CGRectInset(handleRect, 1, 1))
        CGContextSetBlendMode(context, .Clear)
        CGContextFillPath(context)
        
        
    }
    
    var handleRect: CGRect {
        let handleX = (bounds.width - bounds.height) * (value / maxValue)
        return CGRect(x: handleX, y: 0, width: bounds.height, height: bounds.height)

    }
    
    var isTouchingHandle: Bool = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let locPoint = touch.locationInView(self)
            
            isTouchingHandle = CGRectContainsPoint(handleRect, locPoint)
            
        }

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isTouchingHandle {
            if let touch = touches.first {
                let touchX = touch.locationInView(self).x
                let removeRadius = touchX - bounds.height / 2
                let fullDistance = bounds.width - bounds.height
                let percent = removeRadius / fullDistance
                value = percent * maxValue
            }
            
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isTouchingHandle = false
        
    }

}
