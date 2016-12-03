//
//  FractalView.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 11/26/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

class FractalView: UIView {
    
    let PI = 3.141592
    let maxDepth = 18
    
    var leftAngle:Double = 0.1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var rightAngle:Double = 0.1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var depth:Int = 1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // don't redraw if max depth is exceeded
        if depth > maxDepth {
            return
        }
        
        // origin of the base branch
        let treeOrigin = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
        
        drawBranch(origin: treeOrigin, angle: PI/2, depth: depth)
    }
    
    func drawBranch(origin:CGPoint, angle:Double, depth:Int) -> Void {
        
        // calculate the endpoint of this branch
        // calculate the length of the branch based on the current depth and max depth
        let currentDepthDiff = self.depth - depth
        let initialLength = self.bounds.height / 20.0
        let maxDepthDiff = CGFloat(maxDepth - currentDepthDiff)
        let scale = initialLength * ( maxDepthDiff / CGFloat(maxDepth))
        
        let nextX = origin.x + CGFloat(cos(angle)) * scale
        let nextY = origin.y - CGFloat(sin(angle)) * scale
        
        //NSLog("\(origin.x - nextX)")        

        let endpoint = CGPoint.init(x: nextX, y: nextY)
        
        if depth > 0 {
            // draw a line to the endpoint
            drawBranchSegment(lineWidth: 1.0, fromPoint: origin, toPoint:endpoint)
            
            // draw the children branches
            drawBranch(origin: endpoint, angle: angle + leftAngle, depth: depth - 1)
            drawBranch(origin: endpoint, angle: angle - rightAngle, depth: depth - 1)
        }
    }
    
    func drawBranchSegment(lineWidth:CGFloat, fromPoint:CGPoint, toPoint:CGPoint) -> Void {
        let path = UIBezierPath()
        let branchColor = UIColor(netHex: 0x00FF80)
        branchColor.set()
        path.lineWidth = lineWidth
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        path.stroke()
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
