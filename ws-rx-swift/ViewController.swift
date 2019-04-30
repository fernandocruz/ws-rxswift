//
//  ViewController.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 29/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var fromCurrency: UITextField!
    @IBOutlet weak var toCurrency: UITextField!
    @IBOutlet weak var topUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }

}

extension ViewController {
    
    private func setupTextField() {
        fromCurrency.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        fromCurrency.keyboardType = .numberPad
        fromCurrency.textAlignment = .right
        
        toCurrency.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        toCurrency.keyboardType = .numberPad
        toCurrency.textAlignment = .right
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
}

