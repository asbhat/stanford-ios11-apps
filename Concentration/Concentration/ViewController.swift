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
    lazy var game = Concentration(numberOfPairsOfCards: pairsOfCards)

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    private var pairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }

    @IBAction func startNewGame() {
        let alertToConfirmNewGame = UIAlertController(title: "New Game?", message: "All progress will be lost.", preferredStyle: .alert)
        alertToConfirmNewGame.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.resetGame()} ))
        alertToConfirmNewGame.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alertToConfirmNewGame, animated: true)
    }

    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    var themes = [
        Theme(name: "Halloween", emojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🍫"]),
        Theme(name: "Winter", emojis: ["🎅🏻", "🎅🏿", "❄️", "⛄️", "⛷", "🏂", "🎄", "🏔", "🌨", "🎁"]),
        Theme(name: "Occupations", emojis: ["👮🏻‍♀️", "👷🏼‍♀️", "💂🏻‍♂️", "🕵🏾‍♂️", "👩🏼‍⚕️", "👩🏼‍🌾", "👨🏻‍🍳", "👩🏻‍🎤", "👩🏼‍🏫", "👨🏾‍🚀"]),
        Theme(name: "Athletes", emojis: ["⛷", "🏂", "🏋🏿‍♂️", "🤼‍♀️", "🤸🏼‍♀️", "⛹🏻‍♂️", "🤺", "🏄🏼‍♀️", "🏊🏼‍♀️", "🚵🏼‍♀️"]),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐰", "🦊", "🐼", "🐨", "🐯", "🦁", "🐷", "🐵", "🦉", "🐢", "🦖", "🐙"]),
        Theme(name: "Fantasy", emojis: ["🧙🏻‍♂️", "🧝🏻‍♀️", "🧛🏿‍♂️", "🧟‍♀️", "🧞‍♂️", "🧜🏻‍♀️", "🧚🏻‍♀️", "🦄", "🐉", "👼🏽"])
    ]
    lazy var emojiChoices = themes[themes.count.random()].emojis

    /// Dictionary matching card identifier `Int`s to emoji `String`s.
    var emoji = [Int: String]()

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.random()
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    /// Resets all progress and begins a new game.
    private func resetGame() {
        game = Concentration(numberOfPairsOfCards: pairsOfCards)
        flipCount = 0
        emojiChoices = themes[themes.count.random()].emojis
        emoji.removeAll()
        updateViewFromModel()
    }

}

struct Theme {
    let name: String
    let emojis: [String]
}
