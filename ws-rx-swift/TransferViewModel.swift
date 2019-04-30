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

class TransferViewModel {
    
    let fromCurrencyFormmated: Driver<String>
    let toCurrencyFormmated: Driver<String>
    
    init(input: (toCurrencyEvent: Driver<String>,
        fromCurrencyEvent: Driver<String>)) {
        
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
    }
}
