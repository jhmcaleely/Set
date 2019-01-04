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

    static func isFacetSet<T: Equatable>(_ cards: [SetCard], _ facet: (SetCard) -> T) -> Bool {
        if cards.count == SetGame.cardsInSet {
            let values = cards.map(facet)
            return  values[0] == values[1] && values[1] == values[2]
                || (values[0] != values[1] && values[0] != values[2] && values[1] != values[2])
        }
        return false
    }

    func isSetSelected() -> Bool {
        return SetGame.isFacetSet(selectedCards, { $0.number })
            && SetGame.isFacetSet(selectedCards, { $0.symbol })
            && SetGame.isFacetSet(selectedCards, { $0.shading })
            && SetGame.isFacetSet(selectedCards, { $0.color })
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
        gameDeck = SetCard.fullDeck
        gameDeck.shuffle()
        dealSomeCards(number: initialDeal)
    }
    
}
