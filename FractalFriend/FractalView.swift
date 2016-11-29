//
//  FractalView.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 11/26/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

class FractalView: UIScrollView {
    
    let PI = 3.141592
    let maxDepth = 15
    
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
    
    var depth:CGFloat = 1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // draw the first parent branch
        // at PI / 2 radians (90 degrees)
        let treeOrigin = CGPoint.init(x: self.bounds.width / 2.0, y: self.bounds.height)
        drawBranch(origin: treeOrigin, angle: PI / 2.0, depth: CGFloat(depth))
    }
    
    func drawBranch(origin:CGPoint, angle:Double, depth:CGFloat) -> Void {
        
        // calculate the endpoint of this branch
        // calculate the length of the branch based on the current depth and max depth
        let currentDepthDiff = self.depth - depth
        let initialLength = self.bounds.height / 5.0
        let maxDepthDiff = CGFloat(maxDepth) - currentDepthDiff
        let scale = initialLength * ( maxDepthDiff / CGFloat(maxDepth))
        
        let nextX = origin.x + CGFloat(cos(angle)) * scale
        let nextY = origin.y - CGFloat(sin(angle)) * scale
        let endpoint = CGPoint.init(x: nextX, y: nextY)
        
        if depth > 0 {
            // draw a line to the endpoint
            drawBranchSegment(lineWidth: 1.0, fromPoint: origin, toPoint:endpoint)
            
            // draw the children branches and set their origins to the endpoint of this branch
            // use leftAngle and rightAngle to draw the children branches
            drawBranch(origin: endpoint, angle: angle + leftAngle, depth: depth - 1)
            drawBranch(origin: endpoint, angle: angle - rightAngle, depth: depth - 1)
        }
    }
    
    func drawBranchSegment(lineWidth:CGFloat, fromPoint:CGPoint, toPoint:CGPoint) -> Void {
        let path = UIBezierPath()
        UIColor.green.set()
        path.lineWidth = lineWidth
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        path.stroke()
    }
}
