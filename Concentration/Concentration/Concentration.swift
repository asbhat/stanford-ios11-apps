//
//  Concentration.swift
//  Concentration
//
//  Created by Aditya Bhat on 11/22/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

class Concentration {

    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int?

    var score: Double {
        return scoring.currentScore
    }
    private var scoring = Scoring()

    var flipCount = 0

    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoring.updateForMatch()
                } else {
                    scoring.updateForMismatch(at: cards[index].identifier)
                    scoring.updateForMismatch(at: cards[matchIndex].identifier)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                scoring.resetTimer()
            } else {
                // either no cards or 2 cards are face up
                // flip all cards face down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    /// ViewController needs to determine the number of pairs of cards.
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards ([Fisher-Yates Shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle))
        guard cards.count > 1 else { return }
        for (index, remainingCardsToShuffle) in (2...cards.count).reversed().enumerated() {
            let swapIndex = index + remainingCardsToShuffle.random()
            cards.swapAt(index, swapIndex)
        }
    }
}

fileprivate struct Scoring {

    var currentScore = 0.0

    mutating func resetTimer() {
        lastMove = Date()
    }

    mutating func updateForMismatch(at identifier: Int) {
        let multiplier = min(-lastMove.timeIntervalSinceNow / maxSeconds, 1)
        if mismatchedCardIdentifiers.contains(identifier) {
            currentScore -= multiplier.rounded(toDecimalPlaces: 1)
        } else {
            mismatchedCardIdentifiers.append(identifier)
        }
    }

    mutating func updateForMatch() {
        let multiplier = max(maxSeconds / -lastMove.timeIntervalSinceNow, 1)
        currentScore += 2 * multiplier.rounded(toDecimalPlaces: 1)
    }

    private var lastMove = Date()
    private var mismatchedCardIdentifiers = [Int]()
    private let maxSeconds = 5.0
}
