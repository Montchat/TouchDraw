//
//  ViewController.swift
//  TouchDraw
//
//  Created by Joe E. on 9/30/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var chosenTool: Int = 0
    
    @IBOutlet weak var controlPanelView: UIView!
    //control pannel view
    
    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    //the gray area on the top of our app
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        //the apple button that will toggle our control panel to move up
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -300: 0
        view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(1) { () -> Void in
            //providing an animation so that when the controlPannel goes up, it does so slowly, and doesn't look as jarring
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    
    @IBAction func chooseTool(button: UIButton) {
        chosenTool = button.tag
        
        
    }
    
    func startShape(type:ShapeType, withTouch touch: UITouch) {
        let shape = Shape(type: .Circle)
        shape.start = touch.locationInView(view)
        shape.fillColor = UIColor.blackColor()
        
        (view as? DrawView)?.lines.append(shape)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //UITouch represents the location, size, movement, and force on a finger on the screen for a particular event. The force of a touch is available starting in iOS 9 on their devices that suppo rts 3D Touch
            if let touch = touches.first {
                switch chosenTool {
                case 1:
                    let newScribble = Scribble()
                    newScribble.points.append(touch.locationInView(view))
                    newScribble.strokeColor = UIColor.blackColor()
                    newScribble.strokeWidth = 10
                    
                    (view as? DrawView)?.lines.append(newScribble)
                    
                case 2:
                    startShape(.Circle, withTouch: touch)
                    
                case 3:
                    startShape(.Rectangle, withTouch: touch)
                    
                case 4:
                    startShape(.Triangle, withTouch: touch)
                    
                case 5:
                    startShape(.Diamond, withTouch: touch)
                    
                default:
                    let newLine = Line()
                    newLine.start = touch.locationInView(view)
                    newLine.strokeColor = UIColor.blackColor()
                    newLine.strokeWidth = 10
                    
                    (view as? DrawView)?.lines.append(newLine)
                    
                }
                
//                
//                
//            // this is an optional UITouch which sets a touch value equal to the first touch in the array
////            let newLine = Line()
//            // creating a new instance object o the line
////            let locationPoint = touch.locationInView(view)
////            //setting the touch location to a locationPoint. this is a CGPoint
////            newLine.start = locationPoint
//            //setting the start of the line to the location point (the CGPoint that the user touches)
//            
//            //we take the two lines commented out above and we simplify them into one line
//            
////            newLine.start = touch.locationInView(view)
////            newLine.strokeColor = UIColor.blackColor()
////            newLine.strokeWidth = 10
////            //setting the other parameters of the view
////            
////            (view as? DrawView)?.lines.append(newLine)
//////                adding a line to the line array
//                
//            //Adding a Scribble to the viewController
////                let newScribble = Scribble()
////                newScribble.points.append(touch.locationInView(view))
////                newScribble.strokeColor = UIColor.blackColor()
////                newScribble.strokeWidth = 10
////                
////                (view as? DrawView)?.lines.append(newScribble)
////
//////            
////        }
//                let shape = Shape(type: .Diamond)
//                //Adding a triangle to the view
//                shape.start = touch.locationInView(view)
//                shape.fillColor = UIColor.blackColor()
//                //adding  black circle to the view
//                (view as? DrawView)?.lines.append(shape)
//                
//                view.setNeedsDisplay()
            
                
        }
        


        //displays the

//        for touch in touches {
//            //looping for the touches
//            
//        }
        
        }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
                //if it is a scribble, do this:
                currentScribble.points.append(touch.locationInView(view))
                view.setNeedsDisplay()
                
            } else if let currentLine = (view as? DrawView)?.lines.last {
                //if it is not a scribble (is a line) then do this:
                currentLine.end = touch.locationInView(view)
                view.setNeedsDisplay()
                
            }
            
            //setting our touch parameter to the first touch in the array. conditionally unwrapping it.
//            if let currentLine = (view as? DrawView)?.lines.last {
//                //setting the parameter of the endpoint of the line
//                currentLine.end = touch.locationInView(view)
//                
//                view.setNeedsDisplay()
//                //Maks the receiver's entire bounds rectangle as needing to be redrawn.// this resets the draw Rect, so that we can draw the line
//     
//                
//            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
//                currentScribble.points.append(touch.locationInView(view))
//                //adding the location to the scribble points
//                view.setNeedsDisplay()
//                //refreshing the view
//            }

            //Shape:
            
//            if let currentShape = (view as? DrawView)?.lines.last {
//                currentShape.end = touch.locationInView(view)
//                view.setNeedsDisplay()

                
//            }

        }
        
    }
    
}


