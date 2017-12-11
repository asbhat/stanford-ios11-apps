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
        XCTAssert(game.cardsInPlay.count == game.startingNumberOfCards + 3)

        let maxDraws = 81 / 3 - 1
        for _ in 0..<maxDraws {
            game.deal3Cards()
        }
        XCTAssert(game.cardsInPlay.count == 81)

        for _ in 0..<2 {
            game.deal3Cards()
        }
        XCTAssert(game.cardsInPlay.count == 81)
    }

    /// Project 2 Required Task 5: select up to 3 cards
    func testSelection() {
        game.selectCard(at: 0)
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[0])

        game.selectCard(at: 1)
        XCTAssert(game.selectedCards.count == 2)
        XCTAssert(game.selectedCards == [ game.cardsInPlay[0], game.cardsInPlay[1] ])

        game.selectCard(at: 2)
        XCTAssert(game.selectedCards.count == 3)
        XCTAssert(game.selectedCards == [ game.cardsInPlay[0], game.cardsInPlay[1], game.cardsInPlay[2] ])

        game.selectCard(at: 3)
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[3])
    }

    /// Project 2 Required Task 5: allow deselection only when 1 or 2 cards are selected
    func testDeselection() {
        // TODO: Fix for required task 7
        game.selectCard(at: 0)
        game.selectCard(at: 1)
        XCTAssert(game.selectedCards.count == 2)
        XCTAssert(game.selectedCards == [ game.cardsInPlay[0], game.cardsInPlay[1] ])

        game.selectCard(at: 1)
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[0])

        game.selectCard(at: 1)
        game.selectCard(at: 2)
        game.selectCard(at: 2)
        XCTAssert(game.selectedCards.count == 1)
        XCTAssert(game.selectedCards[0] == game.cardsInPlay[2])
    }

    func testMatchedSet() {
        let matchingIndices = findAMatchingSet()
        print("cardsInPlay: \(game.cardsInPlay.enumerated())")
        print("matchingIndices: \(matchingIndices)")
        let _ = matchingIndices.map { game.selectCard(at: $0) }
        print("selectedCards: \(game.selectedCards)")

        XCTAssert(game.selectedCardsMatch!)
    }

    func testSelectedNotMatched() {
        let nonMatchingIndices = findNonMatchingSet()

        let _ = nonMatchingIndices.map { game.selectCard(at: $0) }

        XCTAssertFalse(game.selectedCardsMatch!)
    }
}
