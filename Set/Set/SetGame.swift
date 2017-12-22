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

    init() {
        assert(deck.cards.count >= SetGame.startingNumberOfCards, "deck only has \(deck.cards.count) cards!")  // should always have 81 cards, but...
        for _ in 0..<SetGame.startingNumberOfCards {
            cardsInPlay.append(deck.draw()!)
        }
    }

    /// Selects a card from `cardsInPlay`.
    mutating func selectCard(at index: Int) {
        let card = cardsInPlay[index]
        if selectedCards.count < 3 {
            if selectedCards.contains(card) {
                selectedCards.remove(at: selectedCards.index(of: card)! )
                scoring.updateForDeselection()
            } else {
                selectedCards.append(card)
            }
            scoring.updateFor(match: selectedCardsMatch)
        } else {
            _ = removeMatchedCardsFromPlay(andDraw3Cards: true)
            selectedCards.removeAll()
            if cardsInPlay.contains(card) { selectedCards.append(card) }
        }
    }

    /**
     Moves 3 cards (or all cards if fewer than 3 remain) from the `deck` to `cardsInPlay`.

     If matching is included, checks for matches in selected cards, and cards in play.

     - parameter andIncludeMatching: check for matches in cards selected and in play. Defaults to `true`.
    */
    mutating func deal3Cards(andIncludeMatching: Bool = true) {
        guard deck.cards.count > 0 else { return }
        if andIncludeMatching {
            let matchExisted = removeMatchedCardsFromPlay()
            if !matchExisted, let _ = findMatchingSetCardIndicesInPlay() {
                scoring.updateForDealWithExistingSet()
            }
        }
        for _ in 0..<3 {
            if let newCard = deck.draw() {
                cardsInPlay.append(newCard)
            }
        }
    }

    // MARK: Public read-only

    var deckIsEmpty: Bool {
        return deck.cards.isEmpty
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
    private var scoring = Scoring()

    /**
     Returns if successfully found and handled a match.

     If the selected cards are a match:
     1. Adds them to `matchedCards`.
     2. Removes them from `cardsInPlay`.
     3. Clears all selected cards.
     4. Deals 3 more cards if parameter is `true`.

     - parameter andDraw3Cards: if `true` deals 3 more cards without matching.
    */
    private mutating func removeMatchedCardsFromPlay(andDraw3Cards: Bool = false) -> Bool {
        if let isMatch = selectedCardsMatch, isMatch {
            matchedCards += selectedCards
            _ = selectedCards.map { cardsInPlay.remove(at: cardsInPlay.index(of: $0)!) }
            selectedCards.removeAll()
            if andDraw3Cards { deal3Cards(andIncludeMatching: false) }
            return true
        }
        return false
    }

    /**
     Returns the indices of a matching set within `cardsInPlay`. If no set exists, returns `nil`.

     O(n^3) complexity since it's n Choose 3.
    */
    private func findMatchingSetCardIndicesInPlay() -> [Int]? {
        for index1 in 0..<(cardsInPlay.count-2) {
            for index2 in (index1+1)..<(cardsInPlay.count-1) {
                let (card1, card2) = (cardsInPlay[index1], cardsInPlay[index2])

                let matchingCard = card1.matchedCardInSet(with: card2)
                if let matchingIndex = cardsInPlay[(index2+1)..<cardsInPlay.count].index(of: matchingCard) {
                    return [index1, index2, matchingIndex]
                }
            }
        }
        return nil
    }
}

fileprivate struct Scoring {

    struct PointsPer {
        static let match = 3.0
        /// Penalty for each mismatch (should be negative).
        static let mismatch = -5.0
        /// Penalty for each deselection (should be negative).
        static let deselection = -1.0
        /// Penalty for each `deal3Cards()` when a set already exists in play (should be negative).
        static let dealWithSet = -3.0
    }

    let maxDecimalPlaces = 1
    let maxSeconds: Double = 30

    mutating func updateForDeselection() {
        currentScore += PointsPer.deselection.rounded(toDecimalPlaces: maxDecimalPlaces)
    }

    mutating func updateFor(match: Bool?) {
        if let isMatch = match {
            if isMatch {
                // multiplier goes from 6x -> 1x over 30 seconds
                currentScore += PointsPer.match * max( maxSeconds / -lastMatchAttempt.timeIntervalSinceNow / 5, 1 )
            } else {
                // multiplier goes from 1x -> 4x over 30 seconds
                currentScore += PointsPer.mismatch * min( -lastMatchAttempt.timeIntervalSinceNow / 10 + 1, maxSeconds / 10 + 1)
            }
            currentScore = currentScore.rounded(toDecimalPlaces: maxDecimalPlaces)
            lastMatchAttempt = Date()
        }
    }

    mutating func updateForDealWithExistingSet() {
        currentScore += PointsPer.dealWithSet.rounded(toDecimalPlaces: maxDecimalPlaces)
    }

    private(set) var currentScore = 0.0
    private var lastMatchAttempt = Date()
}
