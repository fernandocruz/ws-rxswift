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
    let disposeBag = DisposeBag()
    let transferSubject = PublishSubject<Transfer>()
    
    @IBOutlet weak var fromCurrency: UITextField!
    @IBOutlet weak var toCurrency: UITextField!
    @IBOutlet weak var topUpButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        SetupBindings()
    }

}

extension ViewController {
    private func SetupBindings() {
        
        let tapEvent = topUpButton.rx.tap.asObservable().share()
        
        tapEvent
            .withLatestFrom(fromCurrency.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { [weak self] amount in
                self?.transferSubject.onNext(Transfer(value: amount))
            }).disposed(by: disposeBag)
        
        tapEvent
            .withLatestFrom(fromCurrency.rx.text.orEmpty.asObservable())
            .flatMap { amount in
                self.getTransferSingle(amount: amount)
            }.debug("Single >>>>>>>")
            .subscribe(onNext: { transfer in
                print("Single emitiu: \(transfer.value)")
            }).disposed(by: disposeBag)
        
        
//        getTransferSingle()
//            .debug("Single >>>>>>>>>>>>")
//            .subscribe(onSuccess: { transfer in
//                print("Single emitiu: \(transfer.value)")
//        }).disposed(by: disposeBag)
        
        getTransferObservable()
            .debug("Observable >>>>>>>>>>>>")
            .subscribe(onNext: { transfer in
                print("Observable emitiu: \(transfer.value)")
            }).disposed(by: disposeBag)
        
        getTransferDriver()
            .debug("Driver >>>>>>>>>>>>>")
            .drive(onNext: { transfer in
                print("Driver emitiu: \(transfer.value)")
        }).disposed(by: disposeBag)
        
    }
    
    
    func getTransferSingle(amount: String) -> Single<Transfer> {
        return transferSubject.asSingle()
    }
    
//    func getTransferSingle(amount: String) -> Single<Transfer> {
//        return Single.just(Transfer(value: amount))
//    }
    
    func getTransferObservable() -> Observable<Transfer> {
        return transferSubject.asObservable()
    }
    
    func getTransferDriver() -> Driver<Transfer> {
        return transferSubject.asDriver(onErrorJustReturn: Transfer(value: "0,00"))
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

