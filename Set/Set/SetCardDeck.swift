//
//  SetCardDeck.swift
//  Set
//
//  Created by Aditya Bhat on 12/5/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct SetCardDeck {

    private(set) var cards = [SetCard]()

    init() {
        for number in SetCard.SetNumber.all {
            for symbol in SetCard.SetSymbol.all {
                for shading in SetCard.SetShading.all {
                    for color in SetCard.SetColor.all {
                        cards.append(SetCard(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }
    }

    mutating func draw() -> SetCard? {
        guard cards.count > 0 else { return nil }
        return cards.remove(at: cards.count.arc4random)
    }

}
