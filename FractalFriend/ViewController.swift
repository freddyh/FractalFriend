//
//  ViewController.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 11/26/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fractalView.contentSize = CGSize(width: UIScreen.main.bounds.width * 2.0, height: UIScreen.main.bounds.height * 2.0)
//        fractalView.minimumZoomScale = 0.1
//        fractalView.maximumZoomScale = 10
    }
    
    @IBOutlet weak var fractalView: FractalView!
    
    @IBAction func depthChanged(_ sender: UIStepper) {
        fractalView.depth = Int(sender.value)
    }
    
    @IBAction func leftAngleChanged(_ sender: UIStepper) {
        fractalView.leftAngle = Double(sender.value)
    }
    
    @IBAction func rightAngleChanged(_ sender: UIStepper) {
        fractalView.rightAngle = Double(sender.value)
    }
    
}

