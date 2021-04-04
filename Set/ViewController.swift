//
//  ViewController.swift
//  Set
//
//  Created by John McAleely on 31/12/2018.
//  Copyright © 2018 John McAleely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let initialDealCount = 12
    static let selectionCount = SetGame.cardsInSet
    
    lazy var game = SetGame(initialDeal: ViewController.initialDealCount)

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var cards: PlayingSurface!
    
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
        game.dealFreshCards(number: 3)
        
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        
        cards.displayCards = game.dealtCards
        
        if game.isSetSelected() {
            dealButton.setTitle("Deal 3 Replacement Cards", for: UIControl.State.normal)
            dealButton.isEnabled = true
        }
        else {
            dealButton.setTitle("Deal 3 More Cards", for: UIControl.State.normal)
            if game.gameDeck.count > 0 {
                dealButton.isEnabled = true
            }
            else {
                dealButton.isEnabled = false
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
    }
}
