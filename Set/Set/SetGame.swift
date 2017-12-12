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
    mutating func selectCard(at index: Int) {
        let card = cardsInPlay[index]
        if selectedCards.count < 3 {
            if selectedCards.contains(card) {
                selectedCards.remove(at: selectedCards.index(of: card)! )
            } else {
                selectedCards.append(card)
            }
        } else {
            if let isMatch = selectedCardsMatch, isMatch {
                matchedCards += selectedCards
                let _ = selectedCards.map { cardsInPlay.remove(at: cardsInPlay.index(of: $0)!) }
                deal3Cards()
            }
            selectedCards.removeAll()
            if cardsInPlay.contains(card) { selectedCards.append(card) }
        }
    }

    /// Moves 3 cards (or all cards if fewer than 3 remain) from the `deck` to `cardsInPlay`.
    mutating func deal3Cards() {
        guard deck.cards.count > 0 else { return }
        for _ in 0..<3 {
            if let newCard = deck.draw() {
                cardsInPlay.append(newCard)
            }
        }
    }

    /**
     Returns whether 3 selected cards are a match (`true`) or not (`false`). If not exactly 3 cards, returns `nil`.

     O(n) complexity when there are 3 `selectedCards`, otherwise O(1).
    */
    var selectedCardsMatch: Bool? {
        func allUniqueOrSame<Element: Hashable>(in array: Array<Element>) -> Bool {
            let uniqueCount = Set(array).count
            return uniqueCount == 1 || uniqueCount == array.count
        }
        guard selectedCards.count == 3 else { return nil }
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
