//
//  ViewController.swift
//  Concentration
//
//  Created by Aditya Bhat on 11/21/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// Game model.
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }

    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var scoreLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }

    @IBAction private func startNewGame() {
        let alertToConfirmNewGame = UIAlertController(title: "New Game?", message: "All progress will be lost.", preferredStyle: .alert)
        alertToConfirmNewGame.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.resetGame()} ))
        alertToConfirmNewGame.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alertToConfirmNewGame, animated: true)
    }

    private func updateViewFromModel() {
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme.cardBack
            }
        }
        view.backgroundColor = currentTheme.background
    }

    private var themes = [
        Theme(name: "Halloween", emojis: "🦇😱🙀😈🎃👻🍭🍬🍎🍫", cardBack: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), background: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        Theme(name: "Winter", emojis: "🎅🏻🎅🏿❄️⛄️⛷🏂🎄🏔🌨🎁", cardBack: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), background: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
        Theme(name: "Occupations", emojis: "👮🏻‍♀️👷🏼‍♀️💂🏻‍♂️🕵🏾‍♂️👩🏼‍⚕️👩🏼‍🌾👨🏻‍🍳👩🏻‍🎤👩🏼‍🏫👨🏾‍🚀", cardBack: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), background: #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)),
        Theme(name: "Athletes", emojis: "⛷🏂🏋🏿‍♂️🤼‍♀️🤸🏼‍♀️⛹🏻‍♂️🤺🏄🏼‍♀️🏊🏼‍♀️🚵🏼‍♀️", cardBack: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), background: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)),
        Theme(name: "Animals", emojis: "🐶🐱🐰🦊🐼🐨🐯🦁🐷🐵🦉🐢🦖🐙", cardBack: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), background: #colorLiteral(red: 0.557056431, green: 0.3943228353, blue: 0.2189383229, alpha: 1)),
        Theme(name: "Fantasy", emojis: "🧙🏻‍♂️🧝🏻‍♀️🧛🏿‍♂️🧟‍♀️🧞‍♂️🧜🏻‍♀️🧚🏻‍♀️🦄🐉👼🏽", cardBack: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), background: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1))
    ]
    private lazy var currentTheme = themes[themes.count.arc4random]
    private lazy var emojiChoices = currentTheme.emojis

    /// Dictionary matching card identifier `Int`s to emoji `String`s.
    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }

    /// Resets all progress and begins a new game.
    private func resetGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        currentTheme = themes[themes.count.arc4random]
        emojiChoices = currentTheme.emojis
        emoji.removeAll()
        updateViewFromModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }

}

struct Theme {
    let name: String
    let emojis: String
    let cardBack: UIColor
    let background: UIColor
}
