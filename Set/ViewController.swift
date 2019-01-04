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
    static let initialDealCount = ViewController.buttonCount / 2
    static let selectionSize = SetGame.cardsInSet
    
    lazy var game = SetGame(initialDeal: ViewController.initialDealCount)

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealButton: UIButton!
    
    static func titleForCard(_ card: SetCard) -> NSAttributedString {
        
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
        
        if let touchedIndex = cardButtons.index(of: sender) {
            
            let touchedCard = game.dealtCards[touchedIndex]
            
            if game.isSetSelected() {
                game.dealReplacementCards()
            }
            else {
                
                if game.selectedCards.count == ViewController.selectionSize && !game.isCardSelected(touchedCard) {
                    game.emptySelection()
                }
                
                game.toggleCardSelection(touchedCard)
            }
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.emptySelection()
        game = SetGame(initialDeal: ViewController.initialDealCount)
        updateViewFromModel()
    }
    
    @IBAction func dealThree(_ sender: UIButton) {
        if game.isSetSelected() {
            game.dealReplacementCards()
        }
        else if game.dealtCards.count < ViewController.buttonCount {
            game.dealSomeCards(number: 3)
        }
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        
        if game.isSetSelected() {
            dealButton.setTitle("Deal 3 Replacement Cards", for: UIControl.State.normal)
            dealButton.isEnabled = true
        }
        else {
            dealButton.setTitle("Deal 3 Cards", for: UIControl.State.normal)
            if game.dealtCards.count < ViewController.buttonCount && game.gameDeck.count > 0 {
                dealButton.isEnabled = true
            }
            else {
                dealButton.isEnabled = false
            }
        }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            if index < game.dealtCards.endIndex {
                let attribtext = ViewController.titleForCard(game.dealtCards[index])
                
                button.setAttributedTitle(attribtext, for: UIControl.State.normal)
                button.layer.borderColor = UIColor.blue.cgColor
                button.layer.borderWidth = 0.0
                button.layer.cornerRadius = 8.0
                
                if game.isCardSelected(game.dealtCards[index]) {
                    button.layer.borderWidth = 3.0
                }
                
                if game.isSetSelected() {
                    button.layer.borderColor = UIColor.red.cgColor
                }

                button.isEnabled = true
            }
            else {
                button.isEnabled = false
                button.layer.borderWidth = 0.0
                button.setTitle(nil, for: UIControl.State.normal)
                button.setAttributedTitle(nil, for: UIControl.State.normal)
            }
        }
    }
}
