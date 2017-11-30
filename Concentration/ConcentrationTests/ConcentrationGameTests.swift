//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by Aditya Bhat on 11/28/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import XCTest
@testable import Concentration

class ConcentrationGameTests: XCTestCase {

    var game = Concentration(numberOfPairsOfCards: 15)

    // MARK: Unit test helper functions

    private func getMatchingCardIndeces() -> (matchIndex1: Int, matchIndex2: Int) {
        let cardIdentifiers = Array( game.cards.map {$0.identifier} )
        let matchIndex1 = cardIdentifiers.index(of: cardIdentifiers.min()!)!
        let matchIndex2 = cardIdentifiers[(matchIndex1+1)...].index(of: cardIdentifiers.min()!)!
        return (matchIndex1, matchIndex2)
    }

    // MARK: Unit tests

    func testAllCardsStartFaceDown() {
        for card in game.cards {
            XCTAssertFalse(card.isFaceUp)
        }
    }

    // TODO: fix `testFlippingSameCard()` later?
    /*
    func testFlippingSameCard() {
        XCTAssert(game.flipCount == 0)

        game.chooseCard(at: 0)
        XCTAssert(game.flipCount == 1)

        game.chooseCard(at: 0)
        XCTAssert(game.flipCount == 1)

        // once more for good measure...
        game.chooseCard(at: 0)
        XCTAssert(game.flipCount == 1)
    }
    */

    func testFlipCount() {
        XCTAssert(game.flipCount == 0)

        var index1 = 0
        var index2 = 1
        var index3 = game.cards.count - 1
        var index4 = index3 - 1

        if game.cards[index1].identifier == game.cards[index2].identifier {
            index1 += 1
            index2 += 1
        }

        if game.cards[index3].identifier == game.cards[index4].identifier {
            index3 -= 1
            index4 -= 1
        }

        game.chooseCard(at: index1)
        game.chooseCard(at: index2)
        XCTAssert(game.flipCount == 2)

        game.chooseCard(at: index3)
        game.chooseCard(at: index4)
        XCTAssert(game.flipCount == 4)

        game.chooseCard(at: index1)
        game.chooseCard(at: index2)
        XCTAssert(game.flipCount == 6)
    }

    func testFlippingMatchedCards() {
        XCTAssert(game.flipCount == 0)

        let (matchIndex1, matchIndex2) = getMatchingCardIndeces()
        game.chooseCard(at: matchIndex1)
        game.chooseCard(at: matchIndex2)
        XCTAssert(game.flipCount == 2)

        game.chooseCard(at: matchIndex1)
        game.chooseCard(at: matchIndex2)
        XCTAssert(game.flipCount == 2)
    }

    func testMismatchScoring() {
        XCTAssert(game.score == 0)
        var baseScore = game.score

        let totalCards = game.cards.count
        var cardIndex = 0
        var repeatFlipCount = 0
        while cardIndex < totalCards, repeatFlipCount < 2 {
            game.chooseCard(at: cardIndex)
            sleep(1)  // need to sleep because of timing in scoring
            game.chooseCard(at: cardIndex+1)
            if game.cards[cardIndex].identifier == game.cards[cardIndex+1].identifier {
                baseScore = game.score
                cardIndex += 2
            } else {
                repeatFlipCount += 1
            }
        }

        XCTAssert(baseScore > game.score)
    }

    func testMatchScoring() {
        XCTAssert(game.score == 0)

        let (matchIndex1, matchIndex2) = getMatchingCardIndeces()

        game.chooseCard(at: matchIndex1)
        sleep(1)
        game.chooseCard(at: matchIndex2)

        XCTAssert(game.score > 0)
    }

    func testCardsAreShuffled() {
        let shuffledIdentifiers = Array( game.cards.map {$0.identifier} )
        let orderedIdentifiers = shuffledIdentifiers.sorted()
        XCTAssert(orderedIdentifiers != shuffledIdentifiers)  // this might return false on very rare occasions...
    }

}
