//
//  FractalController.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 12/3/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

class FractalController: UIViewController {

    @IBOutlet weak var fractalView: FractalView!
    @IBOutlet weak var symmetrySwitch: UISwitch!
    @IBOutlet weak var leftTreeSlider: UISlider!
    @IBOutlet weak var rightTreeSlider: UISlider!
    @IBOutlet weak var depthSlider: UISlider!
    @IBOutlet weak var leftTreeValueLabel: UILabel!
    @IBOutlet weak var rightTreeValueLabel: UILabel!
    @IBOutlet weak var depthValueLabel: UILabel!
    
    let radianData = Array(stride(from: -2*Double.pi, to: 2*Double.pi, by: Double.pi/120))
    let branchData = Array(stride(from: 2, to: 18, by: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveFractalToLibrary))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped(sender:)))
        
        self.setExtremeSliderValues()
        self.generateNewFractal()
    }
    
    func setMinimumSliderValue(_ value: Float) {
        self.leftTreeSlider.minimumValue = value
        self.rightTreeSlider.minimumValue = value
    }
    
    func setMaximumSliderValue(_ value: Float) {
        self.rightTreeSlider.maximumValue = value
        self.leftTreeSlider.maximumValue = value
    }
    
    func setExtremeSliderValues() {
        guard let minimum = self.radianData.first else {
            return
        }
        self.setMinimumSliderValue(Float(minimum))
        
        guard let maximum = self.radianData.last else {
            return
        }
        self.setMaximumSliderValue(Float(maximum))
    }
    
    @objc func shareButtonTapped(sender:UIBarButtonItem) -> Void {
        let ac = UIActivityViewController(activityItems: [self.fractalView.toImage()], applicationActivities: nil)
        guard let navigationController = self.navigationController else {
            return
        }
        navigationController.present(ac, animated: true, completion: nil)
    }
    
    @objc func saveFractalToLibrary() -> Void {
        let screenShot = self.fractalView.toImage()
        UIImageWriteToSavedPhotosAlbum(screenShot, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        guard error == nil else {
            let ac = UIAlertController(title: "Save error", message: error!.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        let ac = UIAlertController(title: "Saved!", message: "The binary fractral tree has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func randomizePickerValues() -> Void {
        
        // choose three random indices
        let leftAngleIndex = Int(arc4random_uniform(UInt32(self.radianData.count)))
        let rightAngleIndex = symmetrySwitch.isOn ? leftAngleIndex : Int(arc4random_uniform(UInt32(self.radianData.count)))
        let depthIndex = Int(arc4random_uniform(UInt32(self.branchData.count)))
        
        // animate the picker to display the values at the random index
        self.leftTreeSlider.setValue(Float(self.radianData[leftAngleIndex]), animated: true);
        self.rightTreeSlider.setValue(Float(self.radianData[rightAngleIndex]), animated: true)
        self.depthSlider.setValue(Float(self.branchData[depthIndex]), animated: true)
        
        updateSliderLabels()
    }
    
    func updateSliderLabels() -> Void {
        self.leftTreeValueLabel.text = String(format: "%.2f", self.leftTreeSlider.value)
        self.rightTreeValueLabel.text = String(format: "%.2f", self.rightTreeSlider.value)
        self.depthValueLabel.text = String(format: "\(Int(self.depthSlider.value))" )
    }
    
    func updateFractalView() -> Void {
        self.fractalView.leftTreeAngle = Double(Int(self.leftTreeSlider.value))
        self.fractalView.rightTreeAngle = Double(Int(self.rightTreeSlider.value))
        self.fractalView.treeDepth = Int(self.depthSlider.value)
    }
    
    func generateNewFractal() -> Void {
        self.randomizePickerValues()
        self.updateFractalView()
    }
    
    @IBAction func leftTreeSliderChanged(_ sender: UISlider) {
        let roundedValue = Double(roundf(sender.value * 100) / 100)
        if self.symmetrySwitch.isOn {
            self.fractalView.rightTreeAngle = roundedValue
            self.rightTreeSlider.setValue(Float(roundedValue), animated: true)
        }
        self.fractalView.leftTreeAngle = roundedValue
        self.fractalView.setNeedsDisplay()
        updateSliderLabels()
    }
    
    @IBAction func rightTreeSliderChanged(_ sender: UISlider) {
        let roundedValue = Double(roundf(sender.value * 100) / 100)
        if self.symmetrySwitch.isOn {
            self.fractalView.leftTreeAngle = roundedValue
            self.leftTreeSlider.setValue(Float(roundedValue), animated: true)
        }
        self.fractalView.rightTreeAngle = roundedValue
        updateSliderLabels()
    }
    
    @IBAction func depthSliderChanged(_ sender: UISlider) {
        self.fractalView.treeDepth = Int(self.depthSlider.value)
        updateSliderLabels()
    }
    
    func forceSymmetry() {
        self.fractalView.leftTreeAngle = self.fractalView.rightTreeAngle
        self.leftTreeSlider.setValue(self.rightTreeSlider.value, animated: true)
        updateSliderLabels()
    }
    
    @IBAction func symmetrySwitchValueChanged(_ sender: UISwitch) {
        forceSymmetry()
    }
    
    @IBAction func forceSymmetryButtonTapped(_ sender: Any) {
        symmetrySwitch.isOn = !symmetrySwitch.isOn
        forceSymmetry()
    }
    
    @IBAction func randomFractalButtonTapped(_ sender: Any) {
        generateNewFractal()
    }
}
