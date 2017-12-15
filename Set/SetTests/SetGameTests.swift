//
//  SetTests.swift
//  SetTests
//
//  Created by Aditya Bhat on 12/3/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import XCTest
@testable import Set

class SetGameTests: XCTestCase {

    var game = SetGame()

    // MARK: Helper functions

    private func findMatching(_ numbers: Set<SetCard.SetNumber>) -> SetCard.SetNumber {
        let allNumbers = Set(SetCard.SetNumber.all)
        if numbers.count == 1 {
            return numbers.first!
        } else {
            return allNumbers.subtracting(numbers).first!
        }
    }

    private func findMatching(_ symbols: Set<SetCard.SetSymbol>) -> SetCard.SetSymbol {
        let allSymbols = Set(SetCard.SetSymbol.all)
        if symbols.count == 1 {
            return symbols.first!
        } else {
            return allSymbols.subtracting(symbols).first!
        }
    }

    private func findMatching(_ shadings: Set<SetCard.SetShading>) -> SetCard.SetShading {
        let allShadings = Set(SetCard.SetShading.all)
        if shadings.count == 1 {
            return shadings.first!
        } else {
            return allShadings.subtracting(shadings).first!
        }
    }

    private func findMatching(_ colors: Set<SetCard.SetColor>) -> SetCard.SetColor {
        let allColors = Set(SetCard.SetColor.all)
        if colors.count == 1 {
            return colors.first!
        } else {
            return allColors.subtracting(colors).first!
        }
    }

    private func findAMatchingSet() -> [Int] {
        for index1 in 0..<(game.cardsInPlay.count-1) {
            for index2 in (index1+1)..<game.cardsInPlay.count {
                let cards = [ game.cardsInPlay[index1], game.cardsInPlay[index2] ]

                let matchingCard = SetCard(
                    number: findMatching(Set(cards.map {$0.number} )),
                    symbol: findMatching(Set(cards.map {$0.symbol} )),
                    shading: findMatching(Set(cards.map {$0.shading} )),
                    color: findMatching(Set(cards.map {$0.color} ))
                )

                if let matchingCardIndex = game.cardsInPlay.index(of: matchingCard) {
                    return [index1, index2, matchingCardIndex]
                }
            }
        }
        game.deal3Cards()
        return findAMatchingSet()
    }

    private func findNonMatchingSet() -> [Int] {
        let cards = game.cardsInPlay[..<3]
        let uniqueCounts = [
            Set(cards.map {$0.number}).count,
            Set(cards.map {$0.symbol}).count,
            Set(cards.map {$0.shading}).count,
            Set(cards.map {$0.color}).count
        ]

        for count in uniqueCounts {
            if count == 2 {
                return [0, 1, 2]
            }
        }

        return [0, 1, 3]
    }

    // MARK: Unit and functional tests

    /// Project 2 Required Task 3: Deal 12 cards to start.
    func testStartWith12Cards() {
        XCTAssert(game.cardsInPlay.count == 12)
    }

    /// Project 2 Required Task 4: "Deal 3 More Cards."
    func testDeal3Cards() {
        game.deal3Cards()
        XCTAssert(game.cardsInPlay.count == SetGame.startingNumberOfCards + 3)

        let maxDraws = (81 - SetGame.startingNumberOfCards) / 3 - 1
        for _ in 0..<maxDraws {
            game.deal3Cards()
        }
        XCTAssert(game.cardsInPlay.count == 81)

        for _ in 0..<2 {
            game.deal3Cards()
        }
        XCTAssert(game.cardsInPlay.count == 81)
    }

    /**
     Project 2 Required Task 5: select up to 3 cards.

     Project 2 Required Task 7: if there are already 3 mismatched cards, only select new card.
    */
    func testSelection() {
        let nonMatchingIndices = findNonMatchingSet()
        game.selectCard(at: nonMatchingIndices[0])
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[nonMatchingIndices[0]])

        game.selectCard(at: nonMatchingIndices[1])
        XCTAssert(game.selectedCards.count == 2)
        XCTAssert(game.selectedCards == [ game.cardsInPlay[nonMatchingIndices[0]], game.cardsInPlay[nonMatchingIndices[1]] ])

        game.selectCard(at: nonMatchingIndices[2])
        XCTAssert(game.selectedCards.count == 3)
        XCTAssert(game.selectedCards == nonMatchingIndices.map { game.cardsInPlay[$0] })

        game.selectCard(at: nonMatchingIndices[0])
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[nonMatchingIndices[0]])
    }

    /**
     Project 2 Required Task 5: allow deselection only when 1 or 2 cards are selected.

     Project 2 Required Task 7: if there are already 3 mismatched cards, deselect all of them.
    */
    func testDeselection() {
        let nonMatchingIndices = findNonMatchingSet()
        game.selectCard(at: nonMatchingIndices[0])
        game.selectCard(at: nonMatchingIndices[1])
        XCTAssert(game.selectedCards.count == 2)
        XCTAssert(game.selectedCards == [ game.cardsInPlay[nonMatchingIndices[0]], game.cardsInPlay[nonMatchingIndices[1]] ])

        game.selectCard(at: nonMatchingIndices[1])
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[nonMatchingIndices[0]])

        game.selectCard(at: nonMatchingIndices[1])
        XCTAssert(game.selectedCards.count == 2)
        game.selectCard(at: nonMatchingIndices[2])
        XCTAssert(game.selectedCards.count == 3)
        game.selectCard(at: nonMatchingIndices[2])
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[2])
    }

    func testMatchedSet() {
        let matchingIndices = findAMatchingSet()
        let _ = matchingIndices.map { game.selectCard(at: $0) }

        XCTAssert(game.selectedCardsMatch!)
    }

    func testSelectedNotMatched() {
        let nonMatchingIndices = findNonMatchingSet()
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }

        XCTAssertFalse(game.selectedCardsMatch!)
    }

    /// Project 2 Required Task 8: if match, replace 3 cards on next selection.
    func testSelectCardAfterMatch() {
        let matchingIndices = findAMatchingSet()
        let startingCountOfCardsInPlay = game.cardsInPlay.count
        var _ = matchingIndices.map { game.selectCard(at: $0) }
        let matchedCards = game.selectedCards

        let cardsInPlayIndices = Array(0..<startingCountOfCardsInPlay)
        let newChoice = Set(cardsInPlayIndices).subtracting(Set(matchingIndices)).first!

        game.selectCard(at: newChoice)
        XCTAssert(game.cardsInPlay.count == startingCountOfCardsInPlay)
        XCTAssert(game.selectedCards.count == 1)

        game.selectCard(at: newChoice)
        _ = matchingIndices.map { game.selectCard(at: $0) }
        XCTAssert(matchedCards != game.selectedCards)
    }

    func testSelectCardAfterMismatch() {
        let nonMatchingIndices = findNonMatchingSet()
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }
        let nonMatchingCards = game.selectedCards

        let cardsInPlayIndices = Array(0..<game.cardsInPlay.count)
        let newChoice = Set(cardsInPlayIndices).subtracting(Set(nonMatchingIndices)).first!

        game.selectCard(at: newChoice)
        XCTAssert(game.cardsInPlay.count == SetGame.startingNumberOfCards)
        XCTAssert(game.selectedCards.count == 1)

        game.selectCard(at: newChoice)
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }
        XCTAssert(nonMatchingCards == game.selectedCards)
    }

    /// Project 2 Required Task 8: if the deck is empty, then matched cards can't be replaced.
    func testSelectCardAfterMatchWithEmptyDeck() {
        let maxDraws = (81 - SetGame.startingNumberOfCards) / 3
        for _ in 0..<maxDraws {
            game.deal3Cards()
        }
        XCTAssert(game.cardsInPlay.count == 81)

        let matchingIndices = findAMatchingSet()
        let _ = matchingIndices.map { game.selectCard(at: $0) }

        game.selectCard(at: 0)
        XCTAssert(game.cardsInPlay.count == 78)
    }

    /// Project 2 Required Task 8: if a matched card is chosen, no card should be selected.
    func testSelectMatchedCardAfterMatch() {
        let matchingIndices = findAMatchingSet()
        let _ = matchingIndices.map { game.selectCard(at: $0) }
        XCTAssert(game.selectedCards.count == 3)

        game.selectCard(at: matchingIndices[0])
        XCTAssert(game.selectedCards.isEmpty)
    }

    /// Project 2 Required Task 9: replace selected cards if they're a match.
    func testDeal3CardsWithMatch() {
        let matchingIndices = findAMatchingSet()
        let startingCountOfCardsInPlay = game.cardsInPlay.count
        let _ = matchingIndices.map { game.selectCard(at: $0) }
        game.deal3Cards()

        XCTAssert(game.matchedCards.count == 3)
        XCTAssert(game.selectedCards.isEmpty)
        XCTAssert(game.cardsInPlay.count == startingCountOfCardsInPlay)
    }

    /// Project 2 Required Task 9: add 3 cards if selected cards are a mismatch.
    func testDeal3CardsWithMismatch() {
        let nonMatchingIndices = findNonMatchingSet()
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }
        game.deal3Cards()

        XCTAssert(game.matchedCards.isEmpty)
        XCTAssert(game.selectedCards.count == 3)
        XCTAssert(game.cardsInPlay.count == SetGame.startingNumberOfCards + 3)
    }

    /// Project 2 Required Task 16: score increases for match
    func testScoringForMatch() {
        let startingScore = game.score

        let matchingIndices = findAMatchingSet()
        let _ = matchingIndices.map { game.selectCard(at: $0) }

        XCTAssert(game.score > startingScore)
    }

    /// Project 2 Required Task 16: score decreases for mismatch
    func testScoringForMismatch() {
        let startingScore = game.score

        let nonMatchingIndices = findNonMatchingSet()
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }

        XCTAssert(game.score < startingScore)
    }

    /// Project 2 Required Task 16: score decreases for deselection
    func testScoringForDeselection() {
        let startingScore = game.score
        game.selectCard(at: 0)
        game.selectCard(at: 0)
        XCTAssert(game.score < startingScore)
    }

    /// Project 2 Extra Credit 1: score incorporates speed of play
    func testScoringForQuickAndSlowMatches() {
        let startingScore = game.score

        var matchingIndices = findAMatchingSet()
        let _ = matchingIndices.map { game.selectCard(at: $0) }
        let quickMatchScoreIncrease = game.score - startingScore

        sleep(3)
        matchingIndices = findAMatchingSet()
        let _ = matchingIndices.map { game.selectCard(at: $0) }
        let slowMatchScoreIncrease = game.score - quickMatchScoreIncrease - startingScore

        XCTAssert(quickMatchScoreIncrease > slowMatchScoreIncrease)
    }

    /// Project 2 Extra Credit 1: score incorporates speed of play
    func testScoringForQuickAndSlowMismatches() {
        let startingScore = game.score

        var nonMatchingIndices = findNonMatchingSet()
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }
        let quickMismatchScoreDecrease = startingScore - game.score

        sleep(3)
        nonMatchingIndices = findNonMatchingSet()
        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }
        let slowMismatchScoreDecrease = startingScore - quickMismatchScoreDecrease - game.score

        XCTAssert(slowMismatchScoreDecrease > quickMismatchScoreDecrease)
    }
}
