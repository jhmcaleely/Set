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
    @IBOutlet weak var dealButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
 
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
