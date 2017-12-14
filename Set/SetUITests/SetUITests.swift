//
//  SetUITests.swift
//  SetUITests
//
//  Created by Aditya Bhat on 12/3/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import XCTest

class SetUITests: XCTestCase {

    let app = XCUIApplication()
    let predicateForCards = NSPredicate(format: "(NOT label CONTAINS[cd] %@) AND (NOT label CONTAINS[cd] %@)", "new game", "deal 3 more cards")
    var cards: [XCUIElement] {
        return app.descendants(matching: .button).matching(predicateForCards).allElementsBoundByIndex
    }

    let startingNumberOfCards = 12

    let buttonNames = ["New Game", "Deal 3 More Cards"]
    let labelNames = ["scoreUILabel"]

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()

        XCUIDevice.shared.orientation = .portrait
    }

    // MARK: UI test helper functions

    private func labelsExist(_ labelArray: [String], callingFile: StaticString = #file, callingLine: UInt = #line) {
        for labelName in labelArray {
            XCTAssert(app.staticTexts[labelName].exists, "\(labelName) label does not exist!", file: callingFile, line: callingLine)
        }
    }

    private func labelsOnScreen(_ labelArray: [String], callingFile: StaticString = #file, callingLine: UInt = #line) {
        let window = app.windows.element(boundBy: 0)
        for labelName in labelArray {
            let label = app.staticTexts[labelName]
            XCTAssert(window.frame.contains(label.frame), file: callingFile, line: callingLine)
        }
    }

    private func buttonsExist(_ buttonArray: [String], callingFile: StaticString = #file, callingLine: UInt = #line) {
        for buttonName in buttonArray {
            XCTAssert(app.buttons[buttonName].exists, "\(buttonName) button does not exist!", file: callingFile, line:callingLine)
        }
    }

    private func buttonsExist(_ buttonArray: [XCUIElement], callingFile: StaticString = #file, callingLine: UInt = #line) {
        for button in buttonArray {
            XCTAssert(button.exists, "\(button) button does not exist!", file: callingFile, line:callingLine)
        }
    }

    private func buttonsOnScreen(_ buttonArray: [String], callingFile: StaticString = #file, callingLine: UInt = #line) {
        let window = app.windows.element(boundBy: 0)
        for buttonName in buttonArray {
            let button = app.buttons[buttonName]
            XCTAssert(window.frame.contains(button.frame), file: callingFile, line: callingLine)
        }
    }

    private func buttonsOnScreen(_ buttonArray: [XCUIElement], callingFile: StaticString = #file, callingLine: UInt = #line) {
        let window = app.windows.element(boundBy: 0)
        for button in buttonArray {
            XCTAssert(window.frame.contains(button.frame), file: callingFile, line: callingLine)
        }
    }

    // MARK: UI tests

    func testLabelsOnScreenWithRotation() {
        labelsExist(labelNames)
        labelsOnScreen(labelNames)
        sleep(2)

        XCUIDevice.shared.orientation = .landscapeLeft
        labelsExist(labelNames)
        labelsOnScreen(labelNames)
        sleep(2)

        XCUIDevice.shared.orientation = .landscapeRight
        labelsExist(labelNames)
        labelsOnScreen(labelNames)
        sleep(2)
    }

    /**
     Project 2 Required Task 2: Have cards on screen.

     Project 2 Required Task 15: UI nicely laid out in portrait and landscape
    */
    func testCardsAreOnScreenWithRotation() {
        buttonsOnScreen(cards)
        sleep(2)

        XCUIDevice.shared.orientation = .landscapeLeft
        buttonsOnScreen(cards)
        sleep(2)

        XCUIDevice.shared.orientation = .landscapeRight
        buttonsOnScreen(cards)
    }

    /// Project 2 Required Task 4: Deal 3 More Cards button.
    func testDeal3MoreCards() {
        app.buttons["Deal 3 More Cards"].tap()
        XCTAssert(cards.count == startingNumberOfCards + 3)

        app.buttons["Deal 3 More Cards"].tap()
        XCTAssert(cards.count == startingNumberOfCards + 3 * 2)
    }

    /**
     Project 2 Required Task 2: Have room for at least 24 cards on screen.

     Project 2 Required Task 15: UI nicely laid out in portrait
    */
    func testHaveRoomForAtLeast24Cards() {
        let numberOfButtonPresses = (24 - startingNumberOfCards) / 3
        for _ in 0..<numberOfButtonPresses {
            app.buttons["Deal 3 More Cards"].tap()
        }
        XCTAssert(cards.count >= 24)
        buttonsOnScreen(cards)
        buttonsOnScreen(buttonNames)
        labelsOnScreen(labelNames)
        sleep(2)

        XCUIDevice.shared.orientation = .landscapeLeft
        buttonsOnScreen(cards)
        buttonsOnScreen(buttonNames)
        labelsOnScreen(labelNames)
        sleep(2)

        XCUIDevice.shared.orientation = .landscapeRight
        buttonsOnScreen(cards)
        buttonsOnScreen(buttonNames)
        labelsOnScreen(labelNames)
    }

    /// Project 2 Required Task 3: Deal 12 cards to start.
    func testStartingNumberOfCards() {
        XCTAssert(cards.count == startingNumberOfCards)
    }

    /// Project 2 Required Task 16: Scoring label
    func testScoreLabel() {
        XCTAssert(app.staticTexts["Score: 0.0"].exists)

        for i in 0..<3 {
            cards[i].tap()
        }
        XCTAssertFalse(app.staticTexts["Score: 0.0"].exists)
    }

    /// Project 2 Required Task 16: New game button.
    func testNewGameButton() {
        let numberOfDraws = 3
        for _ in 0..<numberOfDraws { app.buttons["Deal 3 More Cards"].tap() }
        for i in 0..<3 { cards[i].tap() }
        XCTAssert(cards.count > startingNumberOfCards)
        XCTAssertFalse(app.staticTexts["Score: 0.0"].exists)

        app.buttons["New Game"].tap()
        app.alerts["New Game?"].buttons["Cancel"].tap()
        XCTAssert(cards.count > startingNumberOfCards)
        XCTAssertFalse(app.staticTexts["Score: 0.0"].exists)

        app.buttons["New Game"].tap()
        app.alerts["New Game?"].buttons["OK"].tap()
        XCTAssert(cards.count == startingNumberOfCards)
        XCTAssert(app.staticTexts["Score: 0.0"].exists)
    }
}
