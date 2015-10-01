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
    
    @IBOutlet weak var controlPanelTop: NSLayoutConstraint!
    
    @IBAction func toggleControlPanel(sender: AnyObject) {
        self.controlPanelTop.constant = self.controlPanelView.frame.origin.y == 0 ? -300: 0
        view.setNeedsUpdateConstraints()
        UIView.animateWithDuration(1) { () -> Void in
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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            if let currentScribble = (view as? DrawView)?.lines.last as? Scribble {
                currentScribble.points.append(touch.locationInView(view))
                view.setNeedsDisplay()
                
            } else if let currentLine = (view as? DrawView)?.lines.last {
                currentLine.end = touch.locationInView(view)
                view.setNeedsDisplay()
                
            }
            

        }
        
    }
    
}


