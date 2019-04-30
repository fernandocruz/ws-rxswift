//
//  ViewController.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 29/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Transfer {
    let value: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var fromCurrency: UITextField!
    @IBOutlet weak var toCurrency: UITextField!
    @IBOutlet weak var topUpButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let transferSubject = PublishSubject<Transfer>()
    var viewModel: TransferViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupViewModel()
        setupBindings()
    }

}

extension ViewController {
    
    private func setupViewModel() {
        self.viewModel = TransferViewModel(input: (toCurrencyEvent: self.toCurrency.rx.text.orEmpty.asDriver(),
                                                   fromCurrencyEvent: self.fromCurrency.rx.text.orEmpty.asDriver()))
    }
    
    private func setupBindings() {
        self.viewModel.toCurrencyFormmated
            .drive(self.toCurrency.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.fromCurrencyFormmated
            .drive(self.fromCurrency.rx.text)
            .disposed(by: disposeBag)
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

