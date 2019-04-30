//
//  String+Utils.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 29/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import Foundation

extension String {
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        //swiftlint:disable force_try
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                          range: NSRange(location: 0, length: self.count),
                                                          withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return NumberFormat.format(double: 0, fractionDigits: 2)!
        }
        
        return NumberFormat.format(double: Double(truncating: number), fractionDigits: 2)!
    }
}
