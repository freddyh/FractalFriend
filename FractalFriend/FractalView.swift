//
//  FractalView.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 11/26/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

class FractalView: UIView {
    
    let maxDepth = 13
    var initialBranchLength: CGFloat = 10
    
    let radianData = Array(stride(from: -2*Double.pi, to: 2*Double.pi, by: Double.pi/120))
    let branchData = Array(stride(from: 2, to: 18, by: 1))
    
    var treeDepth: Int = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var leftTreeAngle: Double = 3.14 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var rightTreeAngle: Double = 3.14 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // length of the initial branch
        self.initialBranchLength = self.bounds.height / 20.0
        
        // origin of the base branch
        let treeOrigin = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height*0.5)
        self.drawTree(origin: treeOrigin, angle: Double.pi/2, depth: maxDepth > treeDepth ? treeDepth : maxDepth)
    }
    
    public func toImage() -> UIImage {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func drawTree(origin:CGPoint, angle:Double, depth:Int) -> Void {
        
        // calculate the endpoint of this branch
        // calculate the length of the branch based on the current depth and max depth
        let currentDepthDiff = treeDepth - depth
        let maxDepthDiff = CGFloat(self.maxDepth - currentDepthDiff)
        let scale = self.initialBranchLength * ( maxDepthDiff / CGFloat(self.maxDepth))
        
        let nextX = origin.x + CGFloat(cos(angle)) * scale
        let nextY = origin.y - CGFloat(sin(angle)) * scale
        
        let endpoint = CGPoint.init(x: nextX, y: nextY)
        
        if depth > 0 {
            // draw a line to the endpoint
            drawLine(lineWidth: 1.0, fromPoint: origin, toPoint:endpoint)
            
            // draw the children branches
            drawTree(origin: endpoint, angle: angle + leftTreeAngle, depth: depth - 1)
            drawTree(origin: endpoint, angle: angle - rightTreeAngle, depth: depth - 1)
        }
    }
    
    func drawLine(lineWidth:CGFloat, fromPoint:CGPoint, toPoint:CGPoint) -> Void {
        let path = UIBezierPath()
        
        let distance = hypotf(Float(fromPoint.x - toPoint.x), Float(fromPoint.y - toPoint.y));
        let s = distance/Float(self.initialBranchLength)
        let branchColor = UIColor(hue: 0.5, saturation: 0.8, brightness: CGFloat(1.0 - s), alpha: 1.0)
        
        branchColor.set()
        path.lineWidth = lineWidth
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        path.stroke()
    }
}
