//
//  TransferViewModel.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 30/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

class TransferViewModel {
    
    let service: TransferService
    
    let fromCurrencyFormmated: Driver<String>
    let toCurrencyFormmated: Driver<String>
    let successTransfer: Driver<Protocol>
    let isLoading: Driver<Bool>
    
    init(input: (toCurrencyEvent: Driver<String>,
        fromCurrencyEvent: Driver<String>,
        tap: Signal<Void>),service: TransferService) {
        
        self.service = service
        let activityIndicator = ActivityIndicator()
        
        self.fromCurrencyFormmated = input.toCurrencyEvent
            .filter { !$0.isEmpty }
            .map { amount in
               let amountFormattedToDouble = amount.replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: ",", with: ".")
                let amountDouble = Double(amountFormattedToDouble)! / 4.00
                return String(format: "%.2f", amountDouble).currencyInputFormatting()
        }
        
        self.toCurrencyFormmated = input.fromCurrencyEvent
            .filter { !$0.isEmpty }
            .map { amount in
                let amountFormattedToDouble = amount.replacingOccurrences(of: ".", with: "")
                    .replacingOccurrences(of: ",", with: ".")
                let amountDouble = Double(amountFormattedToDouble)! * 4.00
                return String(format: "%.2f", amountDouble).currencyInputFormatting()
        }
        
        self.successTransfer = input.tap.withLatestFrom(toCurrencyFormmated)
            .flatMapLatest { amount -> Driver<Protocol> in
                return service.makeTransfer(transfer: Transfer(value: amount))
                    .trackActivity(activityIndicator)
                    .asDriver(onErrorJustReturn: Protocol(number: "-",
                                                          transactionValue: "-"))
        }
        
        self.isLoading = activityIndicator.asDriver()
    }
}
