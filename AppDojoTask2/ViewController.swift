//
//  ViewController.swift
//  AppDojoTask2
//
//  Created by hayazaki on 2020/12/08.
//

import UIKit

final class ViewController: UIViewController {
    
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
        numberTextField1.text ?? ""
    }
    
    private var numberText2: String {
        numberTextField2.text ?? ""
    }
    
    private var selectedOperation: Operation? {
        Operation(rawValue: operatorSegmentedControl.selectedSegmentIndex)
    }
    
    private let expressionsMap: [Operation: (Double, Double) -> Double] = [
        .plus:     (+),
        .minus:    (-),
        .multiple: (*),
        .divide:   (/)
    ]
    
    // MARK: Outlets
    @IBOutlet private weak var numberTextField1: UITextField!
    @IBOutlet private weak var numberTextField2: UITextField!
    @IBOutlet private weak var operatorSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var resultLabel: UILabel!

    // MARK: Actions
    @IBAction private func buttuonTapped(_ sender: Any) {
        let validateResult = validate()
        guard validateResult.isValid else {
            resultLabel.text = validateResult.message
            return
        }

        resultLabel.text = calcurateResult().map { String($0) } ?? ""
    }
    
    // MARK: Methods
    private func validate() -> (isValid: Bool, message: String?) {
        let validateResult = validateNumber2NotZero()
        guard validateResult.isValid else {
            return validateResult
        }
        // 他にバリデーションがある場合は追加する
        // .....
        
        return(true, nil)
    }
    
    private func validateNumber2NotZero() -> (isValid: Bool, message: String?) {
        guard let selectedOperation = selectedOperation else {
            fatalError("selectedOperation is nil.")
        }
        
        switch selectedOperation {
        case .divide:
            guard numberText2 != "0" else {
                return(false, "割る数には0以外を入力してください")
            }
            return(true, nil)
        case .plus, .minus, .multiple:
            return(true, nil)
        }
    }
    
    private func calcurateResult() -> Double? {
        guard let selectedOperation = selectedOperation else { return nil }
        guard let expression = expressionsMap[selectedOperation] else { return nil }
        guard let number1 = Double(numberText1) else { return nil }
        guard let number2 = Double(numberText2) else { return nil }
        
        return expression(number1, number2)
    }
}
