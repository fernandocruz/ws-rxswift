//
//  NumberFormat.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 29/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import Foundation

class NumberFormat {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "pt_BR")
        return numberFormatter
    }()
    
    private init() {}
    
    static func format(string: String, fractionDigits: Int = 2) -> String? {
        guard let float = Float(string) else {
            return nil
        }
        
        NumberFormat.numberFormatter.maximumFractionDigits = fractionDigits
        NumberFormat.numberFormatter.minimumFractionDigits = fractionDigits
        return NumberFormat.numberFormatter.string(from: NSNumber(value: float))
    }
    
    static func format(double: Double, fractionDigits: Int = 2) -> String? {
        NumberFormat.numberFormatter.maximumFractionDigits = fractionDigits
        NumberFormat.numberFormatter.minimumFractionDigits = fractionDigits
        return NumberFormat.numberFormatter.string(from: NSNumber(value: double))
    }
    
    static func formatToNumber(string: String, fractionDigits: Int = 2) -> NSNumber? {
        NumberFormat.numberFormatter.maximumFractionDigits = fractionDigits
        NumberFormat.numberFormatter.minimumFractionDigits = fractionDigits
        return NumberFormat.numberFormatter.number(from: string)
    }
}
