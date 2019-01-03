//
//  SetGame.swift
//  Set
//
//  Created by John McAleely on 02/01/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import Foundation

class SetGame
{
    var cards = [SetCard]()
    var dealtCards = [SetCard]()

    func createCards() {
        
        SetCard.Number.allCases.forEach { number in
            SetCard.Symbol.allCases.forEach { symbol in
                SetCard.Shading.allCases.forEach { shade in
                    SetCard.Color.allCases.forEach { color in
                        cards += [SetCard(number: number, symbol: symbol, shading: shade, color: color)]
                    }
                }
            }
        }
        
        cards.shuffle()
    }

    func isSetMember<T: Equatable>(_ values: [T]) -> Bool {
        return values.count == 3
        && values[0] == values[1] && values[1] == values[2]
        || (values[0] != values[1] && values[0] != values[2] && values[1] != values[2])
    }
    
    func isNumberSet(_ cards: [SetCard]) -> Bool {
        var values = [SetCard.Number]()
        for index in cards.indices {
            values += [cards[index].number]
        }
        return isSetMember(values)
    }

    func isSymbolSet(_ cards: [SetCard]) -> Bool {
        var values = [SetCard.Symbol]()
        for index in cards.indices {
            values += [cards[index].symbol]
        }
        return isSetMember(values)
    }
    
    func isShadingSet(_ cards: [SetCard]) -> Bool {
        var values = [SetCard.Shading]()
        for index in cards.indices {
            values += [cards[index].shading]
        }
        return isSetMember(values)
    }
    
    func isColorSet(_ cards: [SetCard]) -> Bool {
        var values = [SetCard.Color]()
        for index in cards.indices {
            values += [cards[index].color]
        }
        return isSetMember(values)
    }

    func isSet(cards: [SetCard]) -> Bool {
        return isNumberSet(cards) && isSymbolSet(cards) && isShadingSet(cards) && isColorSet(cards)
    }
    
    func dealSomeCards(number: Int) {
        for _ in 0..<min(number, cards.count) {
            dealtCards += [cards.removeFirst()]
        }
    }
    
    init(initialDeal: Int) {
        createCards()
        dealSomeCards(number: initialDeal)
    }
    
}
