//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Aditya Bhat on 12/4/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {

    var description: String { return "\(rank)\(suit)" }

    var suit: Suit
    var rank: Rank

    enum Suit: String, CustomStringConvertible {
        case spades = "♠️"
        case hearts = "♥️"
        case clubs = "♣️"
        case diamonds = "♦️"

        var description: String { return self.rawValue }

        static var all: [Suit] = [.spades, .hearts, .clubs, .diamonds]
    }


    /*
    // Probably the BEST way to do this... but doing it different for demonstration purposes
    enum Rank {
        case ace
        case two
        case three
        // ...
        case jack
        case queen
        case king
    }
    */

    enum Rank: CustomStringConvertible {
        case ace
        case face(String)  // bad representation... probably should be another enum for each face card
        case numeric(Int)

        var description: String {
            switch self {
            case .ace: return "A"
            case .face(let kind): return kind
            case .numeric(let pips): return String(pips)
            }
        }

        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0  // bad design! better to return `nil`
            }
        }

        static var all: [Rank] {
            var allRanks: [Rank] = [.ace]
            for pips in 2...10 {
                allRanks.append(.numeric(pips))
            }
            allRanks += [.face("J"), .face("Q"), .face("K")]

            return allRanks
        }
    }
}
