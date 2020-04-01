//
//  MyHeaderView.swift
//  DataStructuresProfiling
//
//  Created by Pavel on 31.03.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import UIKit

protocol MyHeaderDelegate {
    func runTests(numberOfTests: Int, numberOfThreads: Int, completion: () -> Void)
}

class MyHeaderView: UITableViewHeaderFooterView {
    
    var delegate: MyHeaderDelegate?
    
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var countTestLabel: UILabel!
    @IBOutlet weak var countThreadsLabel: UILabel!
    
    private var numberOfTests: Int = 10 {
        didSet {
            countTestLabel?.text = "Count of tests: \(numberOfTests)"
        }
    }
    
    private var numberOfThreads: Int = 1 {
        didSet {
            countThreadsLabel?.text = "Count of concurrency threads: \(numberOfThreads)"
        }
    }
    
    @IBAction func sliderAdjusted(_ sender: UISlider) {
        numberOfTests = Int(ceil(sender.value))
    }
    
    @IBAction func runButtonTouched(_ sender: UIButton) {
        runButton.isEnabled = false
        self.delegate?.runTests(numberOfTests: numberOfTests, numberOfThreads: numberOfThreads) {
            runButton.isEnabled = true
        }
    }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        numberOfThreads = Int(sender.value)
    }
}
