//
//  SetCard.swift
//  Set
//
//  Created by Aditya Bhat on 12/5/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import Foundation

struct SetCard {
    let number: SetNumber
    let symbol: SetSymbol
    let shading: SetShading
    let color: SetColor

    enum SetNumber: Int, SetMatchable {
        case one = 1, two, three

        static let all: [SetNumber] = [.one, .two, .three]
    }
    enum SetSymbol: SetMatchable {
        case symbol1, symbol2, symbol3

        static let all: [SetSymbol] = [.symbol1, .symbol2, .symbol3]
    }
    enum SetShading: SetMatchable {
        case shading1, shading2, shading3

        static let all: [SetShading] = [.shading1, .shading2, .shading3]
    }
    enum SetColor: SetMatchable {
        case color1, color2, color3

        static let all: [SetColor] = [.color1, .color2, .color3]
    }

    /**
     Returns the card to create a matching set with `self` and `other`.

     Given 2 cards there can only be 1 other card that will form a set.

     - parameter other: Card to match with `self`.
    */
    func matchedCardInSet(with other: SetCard) -> SetCard {
        return SetCard(
            number: self.number.matchedElement(with: other.number),
            symbol: self.symbol.matchedElement(with: other.symbol),
            shading: self.shading.matchedElement(with: other.shading),
            color: self.color.matchedElement(with: other.color)
        )
    }
}

extension SetCard: Equatable {
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.number == rhs.number && lhs.symbol == rhs.symbol && lhs.shading == rhs.shading && lhs.color == rhs.color
    }
}
/// A type with `all` associated cases explicitly listed.
protocol EnumValuesAccessible {
    /// Array of all possible associated values.
    static var all: [Self] { get }
}

protocol SetMatchable: EnumValuesAccessible, Hashable {
    func matchedElement(with other: Self) -> Self
}

extension SetMatchable {
    func matchedElement(with other: Self) -> Self {
        let unique = Set([self, other])
        if unique.count == 1 {
            return self
        } else {
            let allOptions = Set(Self.all)
            return allOptions.subtracting(unique).first!
        }
    }
}
