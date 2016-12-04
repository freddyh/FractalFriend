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
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var singleTapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var symmetrySwitch: UISwitch!
    
    let radianData = Array(stride(from: -2*M_PI, to: 2*M_PI, by: M_PI/120))
    let branchData = Array(stride(from: 2, to: 18, by: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        
        generateNewFractal()
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        generateNewFractal()
    }

    func randomizePickerValues() -> Void {
        
        // choose three random indices
        let leftAngle = Int(arc4random_uniform(UInt32(self.radianData.count)))
        let rightAngle = symmetrySwitch.isOn ? leftAngle : Int(arc4random_uniform(UInt32(self.radianData.count)))
        let depth = Int(arc4random_uniform(UInt32(self.branchData.count)))
                
        // animate the picker to display the values at the random index
        self.pickerView.selectRow(leftAngle, inComponent: 0, animated: true)
        self.pickerView.selectRow(rightAngle, inComponent: 1, animated: true)
        self.pickerView.selectRow(depth, inComponent: 2, animated: true)
    }
    
    func updateFractalView() -> Void {
        self.fractalView.leftAngle = self.radianData[self.pickerView.selectedRow(inComponent: 0)]
        self.fractalView.rightAngle = self.radianData[self.pickerView.selectedRow(inComponent: 1)]
        self.fractalView.depth = self.branchData[self.pickerView.selectedRow(inComponent: 2)]
    }
    
    func generateNewFractal() -> Void {
        randomizePickerValues()
        updateFractalView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension FractalController: UIPickerViewDelegate {
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 2 {
            return String(self.branchData[row])
        }
        return String(format: "%.2f", self.radianData[row])//String(self.radianData[row])
    }
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.symmetrySwitch.isOn {
            if component == 0 {
                pickerView.selectRow(row, inComponent: 1, animated: true)
            }
            
            if component == 1 {
                pickerView.selectRow(row, inComponent: 0, animated: true)
            }
        }
        
        updateFractalView()
    }
    
}

extension FractalController: UIPickerViewDataSource {
    
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 2 {
            return self.branchData.count
        }
        return self.radianData.count
    }

    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
}
