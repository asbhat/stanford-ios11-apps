//
//  ViewController.swift
//  PlayingCard
//
//  Created by Aditya Bhat on 12/4/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    override func viewDidLoad() {
        super.viewDidLoad()
        // A good place for debugging code.
        for _ in 1...10 {
            if let card = deck.draw() {
                print(card)
            }
        }
    }

}
