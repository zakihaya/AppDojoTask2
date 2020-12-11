//
//  ViewController.swift
//  AppDojoTask2
//
//  Created by hayazaki on 2020/12/08.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Enum
    private enum Operation: Int {
        // TODO: StoryBoardでSegmented Controlに設定するvalueをこれに統一したい
        case plus = 0
        case minus = 1
        case multiple = 2
        case divide = 3
    }

    // MARK: Properties
    private var numberText1: String {
        get {
            return numberTextField1.text ?? ""
        }
    }
    
    private var numberText2: String {
        get {
            return numberTextField2.text ?? ""
        }
    }
    
    private var selectedOperation: Operation? {
        return Operation(rawValue: operatorSegmentedControl.selectedSegmentIndex)
    }
    
    private let expressionsMap: [Operation: (Double, Double) -> Double] = [
        .plus:     { (a: Double, b: Double) -> Double in a + b },
        .minus:    { (a: Double, b: Double) -> Double in a - b },
        .multiple: { (a: Double, b: Double) -> Double in a * b },
        .divide:   { (a: Double, b: Double) -> Double in a / b }
    ]
    
    // MARK: Outlets
    @IBOutlet private weak var numberTextField1: UITextField!
    @IBOutlet private weak var numberTextField2: UITextField!
    @IBOutlet private weak var operatorSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var resultLabel: UILabel!

    // MARK: Actions
    @IBAction private func buttuonTapped(_ sender: Any) {
        let validateResult = validate()
        if !validateResult.isValid {
            resultLabel.text = validateResult.message
            return
        }

        let result = calcurateResult()
        resultLabel.text = result == nil ? "" : String(result!)
    }
    
    // MARK: Methods
    private func validate() -> (isValid: Bool, message: String?) {
        let validateResult = validateNumber2NotZero()
        if !validateResult.isValid {
            return validateResult
        }
        // 他にバリデーションがある場合は追加する
        // .....
        
        return(true, nil)
    }
    
    private func validateNumber2NotZero() -> (isValid: Bool, message: String?) {
        // 割り算以外の場合はバリデーションしない
        if selectedOperation != .divide {
            return(true, nil)
        }
        if numberText2 == "0" {
            return(false, "割る数には0以外を入力してください")
        }
        return(true, nil)
    }
    
    private func calcurateResult() -> Double? {
        guard selectedOperation != nil else { return nil }
        guard let expression = expressionsMap[selectedOperation!] else { return nil }
        guard let number1 = Double(numberText1) else { return nil }
        guard let number2 = Double(numberText2) else { return nil }
        
        return expression(number1, number2)
    }
    
}

