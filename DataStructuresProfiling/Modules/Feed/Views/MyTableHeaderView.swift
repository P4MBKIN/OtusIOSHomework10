//
//  MyViewTableHeader.swift
//  DataStructuresProfiling
//
//  Created by Pavel Antonov on 12.03.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import UIKit

protocol MyTableHeaderDelegate {
    func runTests(count: Int)
}

class MyTableHeaderView: NibView {
    
    var delegate: MyTableHeaderDelegate?
    
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var countTestLabel: UILabel!
    
    private var numberOfTests: Int = 0 {
        didSet {
            countTestLabel?.text = "Count of tests: \(numberOfTests)"
            runButton.isEnabled = true
        }
    }
    
    @IBAction func sliderAdjusted(_ sender: UISlider) {
        numberOfTests = Int(ceil(sender.value))
    }
    
    @IBAction func runButtonTouched(_ sender: UIButton) {
        self.delegate?.runTests(count: numberOfTests)
    }
    
}
