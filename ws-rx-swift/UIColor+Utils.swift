//
//  UIColor+Utils.swift
//  ws-rx-swift
//
//  Created by Fernando Cruz on 30/04/19.
//  Copyright © 2019 cocoaheads. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(Double(r) / 255.0),
                  green: CGFloat(Double(g) / 255.0),
                  blue: CGFloat(Double(b) / 255.0),
                  alpha: alpha)
    }
    
    @nonobjc class var newBlue: UIColor {
        return UIColor(r: 35, g: 151, b: 212)
    }
    
    @nonobjc class var ebanxLightGray: UIColor {
        return UIColor(r: 203, g: 203, b: 203)
    }
}
