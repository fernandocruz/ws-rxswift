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

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
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
        
        //MAP
//        toCurrency.rx.text.asObservable()
//            .map { text in
//                return "Número Digitado: \(text ?? "")"
//            }.debug("TO Currency >>>>>>>")
//            .subscribe(onNext: { [weak self] text in
//                self?.resultLabel.text = text
//            }).disposed(by: disposeBag)

        //FlatMap
//        fromCurrency.rx.text.asObservable()
//            .flatMap { text in
//                return Observable.just("Número Digitado: \(text ?? "")")
//            }.debug("From Currency >>>>>>")
//            .subscribe(onNext: { [weak self] text in
//                self?.resultLabel.text = text
//            }).disposed(by: disposeBag)
        
        //Combine
//        Observable.combineLatest(toCurrency.rx.text.orEmpty.asObservable(),
//                                 fromCurrency.rx.text.orEmpty.asObservable()) { toCurrency, fromCurrency in
//            return toCurrency != fromCurrency ? "Números Diferentes" : "Números Iguais"
//        }.debug("Combine >>>>>>>>>")
//        .subscribe(onNext: { [weak self] text in
//            self?.resultLabel.text = text
//        }).disposed(by: disposeBag)
        
        //Zip
//        Observable.zip(toCurrency.rx.text.asObservable(),
//                       fromCurrency.rx.text.asObservable()) { toCurrency, fromCurrency in
//            return " To: \(toCurrency ?? "") - From: \(fromCurrency ?? "")"
//        }.debug("ZIP >>>>>>>>>")
//        .subscribe(onNext: { [weak self] text in
//            self?.resultLabel.text = text
//        }).disposed(by: disposeBag)
        
//        Observable.of(fromCurrency.rx.text.orEmpty.asObservable(),
//                      toCurrency.rx.text.orEmpty.asObservable())
//            .switchLatest().debug("SwitchLatest")
//            .subscribe(onNext: { [weak self] text in
//                self?.resultLabel.text = text
//            }).disposed(by: disposeBag)
        
//        Observable.of(toCurrency.rx.text.orEmpty.asObservable(),
//                      fromCurrency.rx.text.orEmpty.asObservable())
//            .switchLatest().debug("SwitchLatest >>>>>>>>>")
//            .subscribe(onNext: { [weak self] text in
//                self?.resultLabel.text = text
//            }).disposed(by: disposeBag)
        
        //Merge
//        Observable.merge(fromCurrency.rx.text.orEmpty.asObservable(),
//                         toCurrency.rx.text.orEmpty.asObservable())
//            .debug("Merge >>>>>>>>>")
//            .subscribe(onNext: { [weak self] text in
//                self?.resultLabel.text = text
//            }).disposed(by: disposeBag)

        //Filter
//        fromCurrency.rx.text.orEmpty.asObservable()
//            .filter { !$0.isEmpty }
//            .map { text -> Double in
//                    let value  = text.replacingOccurrences(of: ".", with: "")
//                        .replacingOccurrences(of: ",", with: ".")
//                    return Double(value)!
//            }
//            .filter { $0 > 100.00 }.debug("From Currency >>>>>>")
//            .subscribe(onNext: { [weak self] value in
//                self?.resultLabel.text = "Valor: \(value) maior que o permitido"
//            }).disposed(by: disposeBag)
        
        //Debounce
//        fromCurrency.rx.text.orEmpty.asObservable()
//            .debounce(3, scheduler: MainScheduler.instance)
//            .debug("Debounce >>>>>>>>>")
//            .subscribe(onNext: { [weak self] text in
//                self?.resultLabel.text = text
//            }).disposed(by: disposeBag)
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

