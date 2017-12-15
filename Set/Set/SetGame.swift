//
//  SetGame.swift
//  Set
//
//  Created by Aditya Bhat on 12/5/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct SetGame {

    // MARK: Public implementation

    static let startingNumberOfCards = 12
    var score: Double {
        return scoring.currentScore
    }

    /// Selects a card from `cardsInPlay`.
    mutating func selectCard(at index: Int) {
        let card = cardsInPlay[index]
        if selectedCards.count < 3 {
            if selectedCards.contains(card) {
                selectedCards.remove(at: selectedCards.index(of: card)! )
                scoring.updateForDeselection(withCountOfCardsInPlay: cardsInPlay.count)
            } else {
                selectedCards.append(card)
            }
            scoring.updateFor(match: selectedCardsMatch, withCountOfCardsInPlay: cardsInPlay.count)
        } else {
            removeMatchedCardsFromPlay(andDeal3Cards: true)
            selectedCards.removeAll()
            if cardsInPlay.contains(card) { selectedCards.append(card) }
        }
    }

    /// Moves 3 cards (or all cards if fewer than 3 remain) from the `deck` to `cardsInPlay`. If there's a match, replaces matched cards.
    mutating func deal3Cards() {
        guard deck.cards.count > 0 else { return }
        removeMatchedCardsFromPlay()
        for _ in 0..<3 {
            if let newCard = deck.draw() {
                cardsInPlay.append(newCard)
            }
        }
    }

    init() {
        assert(deck.cards.count >= SetGame.startingNumberOfCards, "deck only has \(deck.cards.count) cards!")  // should always have 81 cards, but...
        for _ in 0..<SetGame.startingNumberOfCards {
            cardsInPlay.append(deck.draw()!)
        }
    }

    // MARK: Public read-only

    var deckIsEmpty: Bool {
        return deck.cards.count == 0
    }
    private(set) var cardsInPlay = [SetCard]()
    /// Cards selected to try and create a match. Always a subset of `cardsInPlay`.
    private(set) var selectedCards = [SetCard]()
    private(set) var matchedCards = [SetCard]()

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

    // MARK: Private implementation

    private var deck = SetCardDeck()
    private var scoring = Scoring(startingNumberOfCards: SetGame.startingNumberOfCards)

    /**
     If the selected cards are a match:
     1. Adds them to `matchedCards`.
     2. Removes them from `cardsInPlay`.
     3. Clears all selected cards.
     4. Deals 3 more cards if parameter is `true`.

     - parameter andDeal3Cards: if `true` deals 3 more cards.
    */
    private mutating func removeMatchedCardsFromPlay(andDeal3Cards: Bool = false) {
        if let isMatch = selectedCardsMatch, isMatch {
            matchedCards += selectedCards
            let _ = selectedCards.map { cardsInPlay.remove(at: cardsInPlay.index(of: $0)!) }
            selectedCards.removeAll()
            if andDeal3Cards { deal3Cards() }
        }
    }
}

fileprivate struct Scoring {

    let startingNumberOfCards: Int

    let pointsPerMatch: Double = 3
    /// Penalty for each mismatch (should be negative).
    let pointsPerMismatch: Double = -5
    /// Penalty for each deselection (should be negative).
    let pointsPerDeselection: Double = -1
    let maxDecimalPlaces = 1
    let maxSeconds: Double = 30

    mutating func updateForDeselection(withCountOfCardsInPlay: Int) {
        currentScore += pointsPerDeselection * ( Double(withCountOfCardsInPlay) / Double(startingNumberOfCards) )
        currentScore = currentScore.rounded(toDecimalPlaces: maxDecimalPlaces)
    }

    mutating func updateFor(match: Bool?, withCountOfCardsInPlay: Int) {
        if let isMatch = match {
            if isMatch {
                currentScore += pointsPerMatch * ( Double(startingNumberOfCards) / Double(withCountOfCardsInPlay) ) * max( maxSeconds / -lastMatchAttempt.timeIntervalSinceNow, 1 )
            } else {
                currentScore += pointsPerMismatch * ( Double(withCountOfCardsInPlay) / Double(startingNumberOfCards) ) * min( max( -lastMatchAttempt.timeIntervalSinceNow, 1 ), maxSeconds)
            }
            currentScore = currentScore.rounded(toDecimalPlaces: maxDecimalPlaces)
            lastMatchAttempt = Date()
        }
    }

    init(startingNumberOfCards: Int) {
        self.startingNumberOfCards = startingNumberOfCards
    }

    private(set) var currentScore = 0.0
    private var lastMatchAttempt = Date()
}
