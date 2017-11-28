//
//  Extensions.swift
//  Concentration
//
//  Created by Aditya Bhat on 11/24/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

extension Int {
    /// Random `Int` between the current value (exclusive) and zero (inclusive), implementing `arc4random_uniform()`.
    var arc4random: Int {
        if self > 0 {
            return Int( arc4random_uniform( UInt32(self) ) )
        } else if self < 0 {
            return -Int( arc4random_uniform( UInt32( abs(self) ) ) )
        } else {
            return 0
        }
    }
}

extension Double {
    /**
     Returns the value using "schoolbook rounding" to specified decimal places.

     E.g.,
     ```
     (3.14159).rounded(toDecimalPlaces: 1)
     // 3.1
     (3.14159).rounded(toDecimalPlaces: 4)
     // 3.1416
     (15.34).rounded(toDecimalPlaces: -1)
     // 20
     (15.34).rounded(toDecimalPlaces: -2)
     // 0
     (14.34).rounded(toDecimalPlaces: -1)
     // 10
     ```
     - Parameter places: the number of decimal places (can be negative).
    */
    func rounded(toDecimalPlaces places: Int) -> Double {
        let adjustment = pow(10, Double(places))
        return (self * adjustment).rounded() / adjustment
    }
}
