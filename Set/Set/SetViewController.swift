//
//  SetViewController.swift
//  Set
//
//  Created by Aditya Bhat on 12/3/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    private var game = SetGame()
    let startingNumberOfCards = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }

    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func selectCard(_ sender: UIButton) {
        if let cardButtonIndex = cardButtons.index(of: sender) {
            game.selectCard(at: cardButtonIndex)
            updateViewFromModel()
            print("cardButtonIndex: \(cardButtonIndex)")
        }
    }
    @IBAction private func deal3MoreCards() {
        game.deal3Cards()
        updateViewFromModel()
    }

    private func updateViewFromModel() {
        for cardButtonIndex in cardButtons.indices {
            let button = cardButtons[cardButtonIndex]
            if cardButtonIndex < game.cardsInPlay.count {
                let card = game.cardsInPlay[cardButtonIndex]
                display(button, from: card)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                if game.selectedCards.contains(card) {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                    if let isMatch = game.selectedCardsMatch {
                        if isMatch {
                            button.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1).withAlphaComponent(0.9)
                        } else {
                            button.backgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1).withAlphaComponent(0.9)
                        }
                    }
                } else {
                    button.layer.borderWidth = 0
                }
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
    }

    private func display(_ button: UIButton, from card: SetCard) {
        button.setAttributedTitle(attributedString(from: card), for: .normal)
    }

    private func attributedString(from card: SetCard) -> NSAttributedString {
        var attributes = [NSAttributedStringKey : Any]()
        var buttonText: String

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attributes[.paragraphStyle] = paragraphStyle

        switch card.symbol {
        case .symbol1: buttonText = "▲"
        case .symbol2: buttonText = "●"
        case .symbol3: buttonText = "■"
        }

        buttonText = String(repeating: buttonText, count: card.number.rawValue)

        switch card.color {
        case .color1: attributes[.strokeColor] = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
        case .color2: attributes[.strokeColor] = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        case .color3: attributes[.strokeColor] = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        }

        switch card.shading {
        case .shading1:
            attributes[.strokeWidth] = -5.0
            attributes[.foregroundColor] = (attributes[.strokeColor] as! UIColor)
        case .shading2: attributes[.foregroundColor] = (attributes[.strokeColor] as! UIColor).withAlphaComponent(0.15)
        case .shading3: attributes[.strokeWidth] = 5.0
        }

        return NSAttributedString(string: buttonText, attributes: attributes)
    }

    func resetGame() {
        game = SetGame()
        updateViewFromModel()
    }

}