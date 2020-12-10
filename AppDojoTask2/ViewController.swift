//
//  ViewController.swift
//  AppDojoTask2
//
//  Created by hayazaki on 2020/12/08.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    private var number1: Double? {
        get {
            guard let text = numberTextField1.text else { return nil }
            return Double(text)
        }
    }
    
    private var number2: Double? {
        get {
            guard let text = numberTextField2.text else { return nil }
            return Double(text)
        }
    }
    
    private let expressionsMap = [
        0: { (a: Double, b: Double) -> Double in a + b },
        1: { (a: Double, b: Double) -> Double in a - b },
        2: { (a: Double, b: Double) -> Double in a * b },
        3: { (a: Double, b: Double) -> Double in a / b }
    ]
    
    // MARK: Outlets
    @IBOutlet private weak var numberTextField1: UITextField!
    @IBOutlet private weak var numberTextField2: UITextField!
    @IBOutlet private weak var operatorSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var resultLabel: UILabel!

    // MARK: Actions
    @IBAction func buttuonTapped(_ sender: Any) {
        guard let expression = expressionsMap[operatorSegmentedControl.selectedSegmentIndex] else { return }
        
        let result = expression(number1!, number2!)
        
        resultLabel.text = String(result)
    }
    
}

