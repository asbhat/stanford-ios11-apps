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

    @IBOutlet private weak var deal: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func selectCard(_ sender: UIButton) {
        if let cardButtonIndex = cardButtons.index(of: sender) {
            game.selectCard(at: cardButtonIndex)
            updateViewFromModel()
            print("cardButtonIndex: \(cardButtonIndex)")
        }
    }
    @IBAction private func deal3MoreCards() {
        guard canDeal3Cards else { return }
        game.deal3Cards()
        updateViewFromModel()
    }

    private var canDeal3Cards = true {
        willSet {
            var attributes = [NSAttributedStringKey : Any]()
            if newValue {
                attributes[.strikethroughStyle] = NSUnderlineStyle.styleNone.rawValue
                UIView.performWithoutAnimation {
                    deal.setAttributedTitle(NSAttributedString(string: deal.currentTitle!, attributes: attributes), for: .normal)
                    deal.alpha = 1.0
                    deal.layoutIfNeeded()
                }
            } else {
                attributes[.strikethroughStyle] = NSUnderlineStyle.styleThick.rawValue
                UIView.performWithoutAnimation {
                    deal.setAttributedTitle(NSAttributedString(string: deal.currentTitle!, attributes: attributes), for: .normal)
                    deal.alpha = 0.4
                    deal.layoutIfNeeded()
                }
            }
        }
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
        updateDealAbility()
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

    /**
     Disables the `Deal 3 More Cards` button if:
     1. There are no more cards in the Set deck or
     2. There is no more room in the UI to fit 3 more cards

     _Note: there is always room for 3 more cards if the 3 currently-selected cards are a match since you replace them._
    */
    private func updateDealAbility() {
        if game.deckIsEmpty { canDeal3Cards = false }
        else if let isMatch = game.selectedCardsMatch, isMatch { canDeal3Cards = true }
        else if game.cardsInPlay.count > (cardButtons.count - 3) { canDeal3Cards = false }
        else { canDeal3Cards = true }
    }

}
