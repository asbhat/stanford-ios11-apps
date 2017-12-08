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

    enum SetNumber: Int {
        case one = 1, two, three

        static let all: [SetNumber] = [.one, .two, .three]
    }
    enum SetSymbol {
        case symbol1, symbol2, symbol3

        static let all: [SetSymbol] = [.symbol1, .symbol2, .symbol3]
    }
    enum SetShading {
        case shading1, shading2, shading3

        static let all: [SetShading] = [.shading1, .shading2, .shading3]
    }
    enum SetColor {
        case color1, color2, color3

        static let all: [SetColor] = [.color1, .color2, .color3]
    }
}

extension SetCard: Equatable {
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.number == rhs.number && lhs.symbol == rhs.symbol && lhs.shading == rhs.shading && lhs.color == rhs.color
    }
}
