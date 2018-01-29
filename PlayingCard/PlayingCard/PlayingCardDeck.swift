//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Aditya Bhat on 12/4/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct PlayingCardDeck {

    private(set) var cards = [PlayingCard]()

    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }

    mutating func draw() -> PlayingCard? {
        guard cards.count > 0 else { return nil }
        return cards.remove(at: cards.count.arc4random)
    }
}

extension Int {
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
