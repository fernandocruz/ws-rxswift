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

struct Protocol {
    let number: String
    let transactionValue: String
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
        
        let service = MockTransferService()
        self.viewModel = TransferViewModel(input: (toCurrencyEvent: self.toCurrency.rx.text.orEmpty.asDriver(),
                                                   fromCurrencyEvent: self.fromCurrency.rx.text.orEmpty.asDriver(),
                                                   tap: topUpButton.rx.tap.asSignal()),
                                           service: service)
    }
    
    private func setupBindings() {
        self.viewModel.toCurrencyFormmated
            .drive(self.toCurrency.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.fromCurrencyFormmated
            .drive(self.fromCurrency.rx.text)
            .disposed(by: disposeBag)
        
        self.viewModel.isLoading.drive(onNext: { [weak self] isLoading in
            self?.resultLabel.text = isLoading ? "Aguarde estamos Processando a sua Transferência..." : ""
            self?.topUpButton.isEnabled = !isLoading
            self?.topUpButton.backgroundColor = isLoading ? UIColor.lightGray : UIColor.newBlue
        }).disposed(by: disposeBag)
        
        self.viewModel.successTransfer.drive(onNext: { [weak self] newProtocol in
            let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let alertController = UIAlertController(title: "Transfererência realizada com sucesso",
                                          message: "Seu protocolo \(newProtocol.number) para a transferência de U$\(newProtocol.transactionValue)",
                                          preferredStyle: .alert)
            alertController.addAction(alertAction)
            self?.present(alertController, animated:true, completion: nil)
        }).disposed(by: disposeBag)
        
    }

}

extension ViewController {
    
    private func setupButton() {
        self.topUpButton.backgroundColor = UIColor.newBlue
    }
    
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

