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
    //allowing us to toggle the stroke of the width within XCode's interface
    
    @IBInspectable var circleInset: CGFloat = 10
    //figuring out an inset to figure out how far we want the circle to go to the edge of the button
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        //context
        let insetRect = CGRectInset(rect, circleInset, circleInset)
        //insetRect: we give it the inset from above ( the bounds of the button )
        tintColor.set()
        //setting our color
        
        CGContextSetLineWidth(context, strokeWidth)
        //setting the strokeWidth
        CGContextStrokeEllipseInRect(context, insetRect)
        //setting the outer layer and the circle (the blue outside)
        
        let midX = CGRectGetMidX(rect)
        let midY = CGRectGetMidY(rect)
        //we have to set midX and midY because otherwise the arrow we are drawing below will not be set to the approrpriate location
        
        CGContextMoveToPoint(context, circleInset + 5, midY - 5)
        CGContextAddLineToPoint(context, midX, midY + 5)
        CGContextAddLineToPoint(context, rect.width - circleInset - 5, midY - 5)
        //making a down arrow
        
        CGContextStrokePath(context)
        //drawing out the path that we have created (programatically)
        
    }

}