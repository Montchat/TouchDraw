//
//  DrawView.swift
//  TouchDraw
//
//  Created by Joe E. on 9/30/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines = [Line]()
    //Can we put scribbles in the line array? Yes, because anything that a line can do a scribble can do also because it is a subclass of a line. (and more)
    override func drawRect(rect: CGRect) {
        
//different fills and strokes to create images in a view.
//the different Fills and Strokes do different things. For instance, the fill will create a shape that completely fills the shape. a stroke will only do the border around the shape. an ellipse will create a circle. for all of these we need a context
        
//          Part 1(needs to be uncommented)
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.magentaColor().set()
//        CGContextFillRect(context, CGRect(x: 10, y: 10, width: 100, height: 100))
//        CGContextStrokeRect(context, CGRect(x: 200, y: 10, width: 100, height: 100))
//        CGContextFillEllipseInRect(context, CGRect(x: 100, y: 150, width: 100, height: 100))
//        
//        CGContextAddEllipseInRect(context, CGRect(x: 20, y: 300, width: 200, height: 200))
//        CGContextFillPath(context)
//        
//        CGContextAddEllipseInRect(context, CGRect(x: 20, y: 300, width: 200, height: 200))
//        CGContextStrokePath(context)
//        
//        CGContextAddEllipseInRect(context, CGRect(x: 100, y: 300, width: 200, height: 200))
//        UIColor.cyanColor().set()
//        CGContextFillPath(context)
//

//       Part 2: Drawing Lines
//        let context = UIGraphicsGetCurrentContext()
//        UIColor.magentaColor().set()
//        CGContextMoveToPoint(context, 20, 20)
//        CGContextAddLineToPoint(context, 100, 100)
//        
//        //CGContextStrokePath(context) (commented out)
//        
//        //The code above is all one path that we are drawing. The View starts from (0,0). We set the start of the point to (20,20). It draws a line to (100,100)
//        
//        CGContextMoveToPoint(context, 200, 200)
//        CGContextAddLineToPoint(context, 200, 100)
//        
//        CGContextStrokePath(context)
//        
        //The code above will create a new line that starts at point (200,200). and draws backwards to (200,100).
        
        
//      Part 3: Multiple Lines

        let context = UIGraphicsGetCurrentContext()
        
        UIColor.magentaColor().set()
       
        //        Above, we are pulling in creating instances of multipleLines from the class Line below
        
        //We need a loop for an array so that we can draw multiple lines from our array
        
        for line in lines {
            //looping line in lines
            if let start = line.start, let end = line.end {
                if let fillColor = line.fillColor {
                    //if we have a fill color, we are going to do something with the fill
                    fillColor.set()
                    
                    if let shape = line as? Shape {
                        
                        let width = end.x - start.x
                        let height = end.y - start.y
                        
                        let rect = CGRect(x: start.x, y: start.y, width: width, height: height)
                        
                        switch shape.type ?? .Rectangle {
                        case .Circle: CGContextFillEllipseInRect(context, rect)
                        case .Triangle:
                            let top = CGPoint(x: width / 2 + start.x , y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x, y: end.y)
                            
                            CGContextMoveToPoint(context, top.x, top.y)
                            CGContextAddLineToPoint(context, right.x, right.y)
                            CGContextAddLineToPoint(context, left.x, left.y)
                            
                            CGContextFillPath(context)
                            
                        case .Rectangle:
                            CGContextFillRect(context, rect)
                            
                        case .Diamond:

                            let top = CGPoint(x: width / 2 + start.x , y: start.y)
                            let right = end
                            let left = CGPoint(x: start.x, y: end.y)
                            
//                            let midX = CGRectGetMidX(rect)
//                            let midY = CGRectGetMidY(rect)
//
//
//                            print(top)
//                            print(right)
//                            print(left)
                            
                            CGContextMoveToPoint(context, top.x, top.y)
                            CGContextAddLineToPoint(context, right.x, right.y)
//                            CGContextAddLineToPoint(context, bottom.x, bottom.y)

                            CGContextFillPath(context)
                            
                        }
                        
                    }
                    
                }
                
                if let strokeColor = line.strokeColor {
                    
                    CGContextSetLineWidth(context, line.strokeWidth)
                    //setting the line width
                    
                    CGContextSetLineCap(context, .Round)
                    CGContextSetLineJoin(context, .Round)
                    
                    //if we have a stroke color, we are going to do something with the stroke
                    strokeColor.set()
                    //setting the color of the lines
                    CGContextMoveToPoint(context, start.x, start.y)
                    //start
                    
//                    if line is Scribble {
//                        // if the line is of type Scribble do this //***new thing here. "is" is checking for Type
//                    
//                    }
                    if let scribble = line as? Scribble {
                        // if it is a Scribble...
                        CGContextAddLines(context, scribble.points, scribble.points.count)
                        //add the points to the line
                        
                    }
                    
                    CGContextAddLineToPoint(context, end.x, end.y)
                    //end line if not a Scribble
                    
                    CGContextStrokePath(context)
                    //stroke the path
                    
                }
                
            }
            
        }
        
    }
    
}

//Creating a Line Class: for multiple lines
class Line {
    
    var start: CGPoint?
    var end: CGPoint?
    
    var strokeColor: UIColor?
    var fillColor: UIColor?
    
    var strokeWidth: CGFloat = 0
    //Every class of CoreGraphics is going to be using CGFloat, which is why we are using CGFloat over Int (//strokeWidth: Int = 0)
    
}


//Creating a SubClass of the Line, called the Stroke. this is made so that instead of straight lines, we can just scribble on the screens

class Scribble: Line {
    var points = [CGPoint]() {
        didSet {
            start = points.first
            end = points.last
            //a line is going to have a start and an end. but when we scribble we can technically keep adding points to the array of points, and we can set the points to the first and last item in that array.
            
        }
        
    }
    
}

enum ShapeType {
    case Rectangle, Circle, Triangle, Diamond
    
}

class Shape: Line {
    var type: ShapeType!
    
    init(type:ShapeType) {
        self.type = type
        
    }
    
}

//Other notes. The viewController send the message to the view object telling it to draw. It needs to update its view, and we need to tell it what lines are there too