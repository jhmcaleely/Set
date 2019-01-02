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
        
        var cardsToUse = [SetCard]()
        
        SetCard.Number.allCases.forEach { number in
            SetCard.Symbol.allCases.forEach { symbol in
                SetCard.Shading.allCases.forEach { shade in
                    SetCard.Color.allCases.forEach { color in
                        cardsToUse += [SetCard(number: number, symbol: symbol, shading: shade, color: color)]
                    }
                }
            }
        }
        
        for _ in 1...cardsToUse.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cardsToUse.count)))
            cards += [cardsToUse.remove(at: randomIndex)]
        }
    }
    
    func dealSomeCards(number: Int) {
        for _ in 1...number {
            dealtCards += [cards.removeFirst()]
        }
    }
    
    init() {
        createCards()
    }
    
}
