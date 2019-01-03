//
//  ViewController.swift
//  Set
//
//  Created by John McAleely on 31/12/2018.
//  Copyright © 2018 John McAleely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    static let buttonCount = 24
    
    var cardIsSelected = [Bool](repeating: false, count: buttonCount)
    var selectedCards: Int {
        get {
            var selection = 0
            for index in cardIsSelected.indices {
                if cardIsSelected[index] {
                    selection += 1
                }
            }
            return selection
        }
    }
    
    lazy var game = SetGame(initialDeal: 12)

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealButton: UIButton!
    
    func deselectAll() {
        for index in cardIsSelected.indices {
            let button = cardButtons[index]
            button.layer.borderWidth = 0.0
            cardIsSelected[index] = false
        }
    }
    
    func titleForCard(_ card: SetCard) -> NSAttributedString {
        
        let symbols: [SetCard.Symbol : String] = [.squiggle: "■", .diamond: "▲", .oval: "●"]
        let alphas: [SetCard.Shading : CGFloat] = [.open: 1.0, .solid: 1.0, .striped: 0.15]
        let strokeWidths: [SetCard.Shading : Float] = [.open: 3.0, .solid: -3.0, .striped: -3.0]
        let colors: [SetCard.Color : UIColor] = [.green: UIColor.green, .purple: UIColor.purple, .red: UIColor.red]

        let string = String(repeating: symbols[card.symbol]!, count: card.number.rawValue)
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth: strokeWidths[card.shading]!,
            .strokeColor: colors[card.color]!.withAlphaComponent(alphas[card.shading]!),
            .foregroundColor: colors[card.color]!.withAlphaComponent(alphas[card.shading]!)
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let touchedCard = cardButtons.index(of: sender) {
            
            if setPresent() {
                dealReplacementCards()
            }
            else {
                
                if selectedCards == 3 && !cardIsSelected[touchedCard] {
                    deselectAll()
                }
                
                if cardIsSelected[touchedCard] {
                    cardIsSelected[touchedCard] = false
                }
                else {
                    cardIsSelected[touchedCard] = true
                }
            }
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        cardIsSelected = [Bool](repeating: false, count: ViewController.buttonCount)
        game = SetGame(initialDeal: 12)
        updateViewFromModel()
    }
    
    @IBAction func dealThree(_ sender: UIButton) {
        if setPresent() {
            dealReplacementCards()
        }
        else if game.dealtCards.count < ViewController.buttonCount {
            game.dealSomeCards(number: 3)
        }
        updateViewFromModel()
    }
    
    func dealReplacementCards() {
        for index in cardIsSelected.indices.reversed() {
            if cardIsSelected[index] {
                game.dealtCards.remove(at: index)
                cardIsSelected[index] = false
            }
        }
        game.dealSomeCards(number: 3)
    }
    
    func setPresent() -> Bool {
        var setPresent = false
        
        if selectedCards == 3 {
            var selection = [SetCard]()
            for index in 0..<cardIsSelected.count {
                if cardIsSelected[index] {
                    selection += [game.dealtCards[index]]
                }
            }
            setPresent = game.isSet(cards: selection)
        }
        
        return setPresent
    }
    
    func updateViewFromModel() {
        
        if setPresent() {
            dealButton.setTitle("Deal 3 Replacement Cards", for: UIControl.State.normal)
            dealButton.isEnabled = true
        }
        else {
            dealButton.setTitle("Deal 3 Cards", for: UIControl.State.normal)
            if game.dealtCards.count < 24 && game.cards.count > 0 {
                dealButton.isEnabled = true
            }
            else {
                dealButton.isEnabled = false
            }
        }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            if index < game.dealtCards.endIndex {
                let attribtext = titleForCard(game.dealtCards[index])
                
                button.setAttributedTitle(attribtext, for: UIControl.State.normal)
                button.layer.borderColor = UIColor.blue.cgColor
                button.layer.borderWidth = 0.0
                button.layer.cornerRadius = 8.0
                
                if cardIsSelected[index] {
                    button.layer.borderWidth = 3.0
                }
                
                if setPresent() {
                    button.layer.borderColor = UIColor.red.cgColor
                }

                button.isHidden = false
            }
            else {
                button.isHidden = true
                button.setTitle(nil, for: UIControl.State.normal)
                button.setAttributedTitle(nil, for: UIControl.State.normal)
            }
        }
    }
}




