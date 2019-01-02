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
        startGame()
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
    
    lazy var game = SetGame()

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    func deselectAll() {
        for index in cardIsSelected.indices {
            let button = cardButtons[index]
            button.layer.borderWidth = 0.0
            cardIsSelected[index] = false
        }
    }
    
    func displayCard(_ card: SetCard) -> NSAttributedString {
        var string: String
        var alpha: CGFloat
        var strokeWidth: Float
        var color: UIColor
        
        switch card.symbol {
        case .squiggle: string = "■"
        case .diamond: string = "▲"
        case .oval: string = "●"
        }
        
        switch card.number {
        case .one: break
        case .two: string += string
        case .three: string += string + string
        }
        
        switch card.shading {
        case .open:
            strokeWidth = 3.0
            alpha = 1.0
        case .solid:
            strokeWidth = -3.0
            alpha = 1.0
        case .striped:
            strokeWidth = -3.0
            alpha = 0.15
        }
        
        switch card.color {
        case .green: color = UIColor.green
        case .purple: color = UIColor.purple
        case .red: color = UIColor.red
        }

        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth: strokeWidth,
            .strokeColor: color.withAlphaComponent(alpha),
            .foregroundColor: color.withAlphaComponent(alpha)
        ]
        let attribtext = NSAttributedString(string: string, attributes: attributes)
        
        return attribtext
    }
    
    func startGame() {
        cardIsSelected = [Bool](repeating: false, count: ViewController.buttonCount)
        game = SetGame()
        game.dealSomeCards(number: 12)
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let touchedCard = cardButtons.index(of: sender) {
            
            if setPresent() {
                for index in cardIsSelected.indices.reversed() {
                    if cardIsSelected[index] {
                        game.dealtCards.remove(at: index)
                        cardIsSelected[index] = false
                    }
                }
                game.dealSomeCards(number: 3)
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
        startGame()
    }
    
    @IBAction func dealThree(_ sender: UIButton) {
        if game.dealtCards.count < ViewController.buttonCount {
            game.dealSomeCards(number: 3)
        }
        updateViewFromModel()
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
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            if index < game.dealtCards.endIndex {
                let attribtext = displayCard(game.dealtCards[index])
                
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
            }
        }
    }
}




