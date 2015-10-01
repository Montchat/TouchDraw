//
//  ToggleButton.swift
//  TouchDraw
//
//  Created by Joe E. on 10/1/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

@IBDesignable class ToggleButton: UIButton {
    @IBInspectable var strokeWidth: CGFloat = 1
    
    @IBInspectable var circleInset: CGFloat = 10

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let insetRect = CGRectInset(rect, circleInset, circleInset)
        tintColor.set()
        
        CGContextSetLineWidth(context, strokeWidth)
        CGContextStrokeEllipseInRect(context, insetRect)
        
        let midX = CGRectGetMidX(rect)
        let midY = CGRectGetMidY(rect)
        
        CGContextMoveToPoint(context, circleInset + 5, midY - 5)
        CGContextAddLineToPoint(context, midX, midY + 5)
        CGContextAddLineToPoint(context, rect.width - circleInset - 5, midY - 5)
        
        CGContextStrokePath(context)
        
    }

}