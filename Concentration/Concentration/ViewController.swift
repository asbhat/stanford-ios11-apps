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

    private var pairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
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

    var themes = [
        Theme(name: "Halloween", emojis: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🍫"], cardBack: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), background: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        Theme(name: "Winter", emojis: ["🎅🏻", "🎅🏿", "❄️", "⛄️", "⛷", "🏂", "🎄", "🏔", "🌨", "🎁"], cardBack: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), background: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
        Theme(name: "Occupations", emojis: ["👮🏻‍♀️", "👷🏼‍♀️", "💂🏻‍♂️", "🕵🏾‍♂️", "👩🏼‍⚕️", "👩🏼‍🌾", "👨🏻‍🍳", "👩🏻‍🎤", "👩🏼‍🏫", "👨🏾‍🚀"], cardBack: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), background: #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)),
        Theme(name: "Athletes", emojis: ["⛷", "🏂", "🏋🏿‍♂️", "🤼‍♀️", "🤸🏼‍♀️", "⛹🏻‍♂️", "🤺", "🏄🏼‍♀️", "🏊🏼‍♀️", "🚵🏼‍♀️"], cardBack: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), background: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐰", "🦊", "🐼", "🐨", "🐯", "🦁", "🐷", "🐵", "🦉", "🐢", "🦖", "🐙"], cardBack: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), background: #colorLiteral(red: 0.557056431, green: 0.3943228353, blue: 0.2189383229, alpha: 1)),
        Theme(name: "Fantasy", emojis: ["🧙🏻‍♂️", "🧝🏻‍♀️", "🧛🏿‍♂️", "🧟‍♀️", "🧞‍♂️", "🧜🏻‍♀️", "🧚🏻‍♀️", "🦄", "🐉", "👼🏽"], cardBack: #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), background: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1))
    ]
    lazy var currentTheme = themes[themes.count.random()]
    lazy var emojiChoices = currentTheme.emojis

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
        currentTheme = themes[themes.count.random()]
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
    let emojis: [String]
    let cardBack: UIColor
    let background: UIColor
}
