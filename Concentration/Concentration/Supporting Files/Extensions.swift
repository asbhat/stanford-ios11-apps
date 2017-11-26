//
//  Extensions.swift
//  Concentration
//
//  Created by Aditya Bhat on 11/24/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

extension Int {
    /// Returns a random `Int` less than the current value, implementing `arc4random_uniform()`.
    func random() -> Int {
        return Int( arc4random_uniform( UInt32(self) ) )
    }
}
