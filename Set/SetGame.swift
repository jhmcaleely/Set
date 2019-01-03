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
    var gameDeck = [SetCard]()
    var dealtCards = [SetCard]()
    var selectedCards = [SetCard]()
    static let cardsInSet = 3

    func isSetMember<T: Equatable>(_ values: [T]) -> Bool {
        return values.count == SetGame.cardsInSet
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
    
    func isSetSelected() -> Bool {
        return selectedCards.count == SetGame.cardsInSet
            && isNumberSet(selectedCards) && isSymbolSet(selectedCards) && isShadingSet(selectedCards) && isColorSet(selectedCards)
    }
    
    func isCardSelected(_ card: SetCard) -> Bool {
        return selectedCards.contains(card)
    }
    
    func toggleCardSelection(_ card: SetCard) {
        
        if let i = selectedCards.firstIndex(of: card) {
            selectedCards.remove(at: i)
        }
        else {
            selectedCards += [card]
        }
    }
    
    func emptySelection() {
        selectedCards.removeAll()
    }
    
    func dealSomeCards(number: Int) {
        for _ in 0..<min(number, gameDeck.count) {
            dealtCards += [gameDeck.removeFirst()]
        }
    }
    
    func dealReplacementCards() {
        for index in selectedCards.indices {
            if let i = dealtCards.firstIndex(of: selectedCards[index]) {
                dealtCards.remove(at: i)
            }
        }
        dealSomeCards(number: selectedCards.count)
        emptySelection()
    }
    
    init(initialDeal: Int) {
        gameDeck = SetCard.createDeck()
        gameDeck.shuffle()
        dealSomeCards(number: initialDeal)
    }
    
}
