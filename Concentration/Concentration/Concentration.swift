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

    var score = 0
    private var mismatchedCardIdentifiers = [Int]()

    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    updateScoreForMismatch(at: index)
                    updateScoreForMismatch(at: matchIndex)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
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

    private func updateScoreForMismatch(at index: Int) {
        let identifier = cards[index].identifier
        if mismatchedCardIdentifiers.contains(identifier) {
            score -= 1
        } else {
            mismatchedCardIdentifiers.append(identifier)
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
