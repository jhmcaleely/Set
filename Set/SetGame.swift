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
    
    func isSet(cards: [SetCard]) -> Bool {
        if cards.count == 3 {
            if cards[0].number == cards[1].number && cards[1].number == cards[2].number
            || (cards[0].number != cards[1].number && cards[0].number != cards[2].number
                && cards[1].number != cards[2].number)
            {
                print("number set!")
                if cards[0].symbol == cards[1].symbol && cards[1].symbol == cards[2].symbol
                    || (cards[0].symbol != cards[1].symbol && cards[0].symbol != cards[2].symbol
                        && cards[1].symbol != cards[2].symbol)
                {
                    print("symbol set!")
                    if cards[0].shading == cards[1].shading && cards[1].shading == cards[2].shading
                        || (cards[0].shading != cards[1].shading && cards[0].shading != cards[2].shading
                            && cards[1].shading != cards[2].shading)
                    {
                        print("shading set!")
                        if cards[0].color == cards[1].color && cards[1].color == cards[2].color
                            || (cards[0].color != cards[1].color && cards[0].color != cards[2].color
                                && cards[1].color != cards[2].color)
                        {
                            print("color set!")
                            print("set!!")
                            return true;
                        }
                    }
                }
            }
        }
        return false
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
