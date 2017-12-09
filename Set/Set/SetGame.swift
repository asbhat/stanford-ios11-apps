//
//  SetGame.swift
//  Set
//
//  Created by Aditya Bhat on 12/5/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct SetGame {

    private var deck = SetCardDeck()

    private(set) var cardsInPlay = [SetCard]()
    /// Cards selected to try and create a match. Always a subset of `cardsInPlay`.
    private(set) var selectedCards = [SetCard]()
    private(set) var matchedCards = [SetCard]()

    let startingNumberOfCards = 12

    /// Selects a card from `cardsInPlay`.
    func selectCard(at index: Int) {}  // TODO: make a public selectACard()
    /// Moves 3 cards (or all cards if fewer than 3 remain) from the `deck` to `cardsInPlay`.
    mutating func deal3Cards() {
        guard deck.cards.count > 0 else { return }
        for _ in 0..<3 {
            if let newCard = deck.draw() {
                cardsInPlay.append(newCard)
            }
        }
    }

    var selectedCardsMatch: Bool {
        func allUniqueOrSame<Element: Hashable>(in array: Array<Element>) -> Bool {
            let uniqueCount = Set(array).count
            return uniqueCount == 1 || uniqueCount == array.count
        }

        if allUniqueOrSame(in: selectedCards.map { $0.number } ),
            allUniqueOrSame(in: selectedCards.map { $0.symbol } ),
            allUniqueOrSame(in: selectedCards.map { $0.shading } ),
            allUniqueOrSame(in: selectedCards.map { $0.color } ) {
            return true
        }
        return false
    }

    init() {
        assert(deck.cards.count >= startingNumberOfCards, "deck only has \(deck.cards.count) cards!")  // should always have 81 cards, but...
        for _ in 0..<startingNumberOfCards {
            cardsInPlay.append(deck.draw()!)
        }
    }
}
