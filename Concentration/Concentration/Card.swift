//
//  Card.swift
//  Concentration
//
//  Created by Aditya Bhat on 11/22/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct Card: Hashable {

    var hashValue: Int { return identifier }

    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    /// The unique representation of a card. (UI indendepent so no emojis).
    private var identifier: Int

    /// Stored at the `struct` level to keep unique across instances.
    private static var identifierFactory = 0

    /// Returns a new card's unique identifier.
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    /// Need a custom init so initialized properties don't have to be set.
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
