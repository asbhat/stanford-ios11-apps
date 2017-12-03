//
//  Concentration.swift
//  Concentration
//
//  Created by Aditya Bhat on 11/22/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct Concentration {

    private(set) var cards = [Card]()

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    var score: Double {
        return scoring.currentScore
    }
    private var scoring = Scoring()

    private(set) var flipCount = 0

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoring.updateForMatch()
                } else {
                    scoring.updateForMismatch(card: cards[index])
                    scoring.updateForMismatch(card: cards[matchIndex])
                }
                cards[index].isFaceUp = true
                scoring.resetTimer()
            } else {
                // either no cards or 2 cards are face up
                // flip all cards face down
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    /// ViewController needs to determine the number of pairs of cards.
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards): Need at least one pair")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards ([Fisher-Yates Shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle))
        guard cards.count > 1 else { return }
        for (index, remainingCardsToShuffle) in (2...cards.count).reversed().enumerated() {
            let swapIndex = index + remainingCardsToShuffle.arc4random
            cards.swapAt(index, swapIndex)
        }
    }
}

fileprivate struct Scoring {

    var currentScore = 0.0

    mutating func resetTimer() {
        lastMove = Date()
    }

    mutating func updateForMismatch(card: Card) {
        let multiplier = min(-lastMove.timeIntervalSinceNow / maxSeconds, 1)
        if mismatchedCardIdentifiers.contains(card) {
            currentScore -= multiplier.rounded(toDecimalPlaces: 1)
        } else {
            mismatchedCardIdentifiers.append(card)
        }
    }

    mutating func updateForMatch() {
        let multiplier = max(maxSeconds / -lastMove.timeIntervalSinceNow, 1)
        currentScore += 2 * multiplier.rounded(toDecimalPlaces: 1)
    }

    private var lastMove = Date()
    private var mismatchedCardIdentifiers = [Card]()
    private let maxSeconds = 5.0
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
