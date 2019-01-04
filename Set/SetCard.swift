//
//  SetCard.swift
//  Set
//
//  Created by John McAleely on 02/01/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import Foundation

// a card for the Set game. Each card has 4 facets: Number, Symbol, Shading & Color
struct SetCard: Equatable
{
    static var fullDeck: [SetCard] {
        get {
            var cards = [SetCard]()
            Number.allCases.forEach { number in
                Symbol.allCases.forEach { symbol in
                    Shading.allCases.forEach { shade in
                        Color.allCases.forEach { color in
                            cards += [SetCard(number: number, symbol: symbol, shading: shade, color: color)]
                        }
                    }
                }
            }
            return cards
        }
    }
    
    enum Number: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Symbol: CaseIterable {
        case diamond, squiggle, oval
    }
    
    enum Shading: CaseIterable {
        case solid, striped, open
    }
    
    enum Color: CaseIterable {
        case red, green, purple
    }
    
    let number: Number
    let symbol: Symbol
    let shading: Shading
    let color: Color
}
