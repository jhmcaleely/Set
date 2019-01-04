//
//  ViewController.swift
//  Set
//
//  Created by John McAleely on 31/12/2018.
//  Copyright © 2018 John McAleely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let buttonCount = 24
    static let initialDealCount = 12
    static let selectionCount = SetGame.cardsInSet
    
    lazy var game = SetGame(initialDeal: ViewController.initialDealCount)

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardButtons.forEach {
            $0.layer.cornerRadius = 8.0
            $0.setTitle(nil, for: UIControl.State.normal)
        }
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let touchedIndex = cardButtons.index(of: sender) {
            
            let touchedCard = game.dealtCards[touchedIndex]
            
            if game.isSetSelected() {
                game.dealReplacementCards()
            }
            else {
                
                if game.selectedCards.count == ViewController.selectionCount {
                    game.emptySelection()
                }
                
                game.toggleCardSelection(touchedCard)
            }
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = SetGame(initialDeal: ViewController.initialDealCount)
        updateViewFromModel()
    }
    
    @IBAction func dealCards(_ sender: UIButton) {
        if game.isSetSelected() {
            game.dealReplacementCards()
        }
        else if game.dealtCards.count < ViewController.buttonCount {
            game.dealFreshCards(number: 3)
        }
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        
        if game.isSetSelected() {
            dealButton.setTitle("Deal 3 Replacement Cards", for: UIControl.State.normal)
            dealButton.isEnabled = true
        }
        else {
            dealButton.setTitle("Deal 3 More Cards", for: UIControl.State.normal)
            if game.dealtCards.count < ViewController.buttonCount && game.gameDeck.count > 0 {
                dealButton.isEnabled = true
            }
            else {
                dealButton.isEnabled = false
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            if index < game.dealtCards.endIndex {
                let attribtext = ViewController.titleForCard(game.dealtCards[index])
                
                button.setAttributedTitle(attribtext, for: UIControl.State.normal)
                button.layer.borderWidth = game.isCardSelected(game.dealtCards[index]) ? 3.0 : 0.0
                if game.isSetSelected() {
                    button.layer.borderColor = UIColor.red.cgColor
                }
                else if game.selectedCards.count == ViewController.selectionCount {
                    button.layer.borderColor = UIColor.darkGray.cgColor
                }
                else {
                    button.layer.borderColor = UIColor.blue.cgColor
                }
                button.layer.backgroundColor = UIColor.lightGray.cgColor

                button.isEnabled = true
            }
            else {
                button.isEnabled = false

                button.setAttributedTitle(nil, for: UIControl.State.normal)
                button.layer.borderWidth = 0.0
                button.layer.backgroundColor = UIColor.white.cgColor
            }
        }
    }

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
}
