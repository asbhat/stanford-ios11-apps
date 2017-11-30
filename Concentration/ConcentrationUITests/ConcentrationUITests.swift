//
//  ConcentrationUITests.swift
//  ConcentrationUITests
//
//  Created by Aditya Bhat on 11/28/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import XCTest

class ConcentrationUITests: XCTestCase {

    let app = XCUIApplication()
    let predicateForCards = NSPredicate(format: "NOT label CONTAINS[cd] %@", "new game")
    lazy var cards = app.descendants(matching: .button).matching(predicateForCards).allElementsBoundByIndex

    let labelNames = ["flipCountUILabel", "scoreUILabel"]
    let buttonNames = ["New Game"]

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

    func testLabelsExistAndAreOnScreen() {
        labelsExist(labelNames)
        labelsOnScreen(labelNames)
    }

    func testButtonsExistAndAreOnScreen() {
        buttonsExist(buttonNames)
        buttonsOnScreen(buttonNames)
    }

    func testCardsAreOnScreen() {
        buttonsOnScreen(cards)
    }

    func testAllCardsStartFaceDown() {
        for card in cards {
            XCTAssert(card.label == "")
        }
    }

    func testFlippingCards() {
        XCTAssert(app.staticTexts["Flips: 0"].exists)

        cards[0].tap()
        XCTAssert(app.staticTexts["Flips: 1"].exists)
        XCTAssert(cards[0].label != "")
        XCTAssert(cards[1].label == "")
        XCTAssert(cards[2].label == "")
        XCTAssert(cards[3].label == "")

        cards[1].tap()
        XCTAssert(app.staticTexts["Flips: 2"].exists)
        XCTAssert(cards[0].label != "")
        XCTAssert(cards[1].label != "")
        XCTAssert(cards[2].label == "")
        XCTAssert(cards[3].label == "")

        cards[2].tap()
        XCTAssert(app.staticTexts["Flips: 3"].exists)
        XCTAssert(cards[0].label == "")
        XCTAssert(cards[1].label == "")
        XCTAssert(cards[2].label != "")
        XCTAssert(cards[3].label == "")

        cards[3].tap()
        XCTAssert(app.staticTexts["Flips: 4"].exists)
        XCTAssert(cards[0].label == "")
        XCTAssert(cards[1].label == "")
        XCTAssert(cards[2].label != "")
        XCTAssert(cards[3].label != "")
    }

    /// Programming Project 1 Required Task 2: add more cards.
    func testMoreCards() {
        XCTAssert(cards.count > 16)
        // Bonus, would never finish if don't have an even number of cards
        XCTAssert(Double(cards.count).remainder(dividingBy: 2) == 0)
    }

    /// Programming Project 1 Required Task 3: new game button.
    func testNewGameAlert() {
        XCTAssert(app.staticTexts["Flips: 0"].exists)
        XCTAssert(app.staticTexts["Score: 0.0"].exists)

        // loop twice
        for _ in 0..<2 {
            cards[0].tap()
            cards[1].tap()
            cards[19].tap()
            cards[18].tap()
        }
        XCTAssertFalse(app.staticTexts["Flips: 0"].exists)
        XCTAssertFalse(app.staticTexts["Score: 0.0"].exists)

        app.buttons["New Game"].tap()
        app.alerts["New Game?"].buttons["Cancel"].tap()
        XCTAssertFalse(app.staticTexts["Flips: 0"].exists)
        XCTAssertFalse(app.staticTexts["Score: 0.0"].exists)

        app.buttons["New Game"].tap()
        app.alerts["New Game?"].buttons["OK"].tap()
        XCTAssert(app.staticTexts["Flips: 0"].exists)
        XCTAssert(app.staticTexts["Score: 0.0"].exists)
    }

}
