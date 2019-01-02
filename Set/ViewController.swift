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
    
    var cardIsSelected = [Bool]()
    var selectedCards: Int = 0

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    func deselectAll() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.layer.borderWidth = 0.0
            cardIsSelected[index] = false
            selectedCards = 0
        }
    }
    
    func displayCard(_ card: SetCard) -> NSAttributedString {
        var attributes = [NSAttributedString.Key : Any]()
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
            strokeWidth = 3.0
            alpha = 0.15
        }
        
        switch card.color {
        case .green: color = UIColor.green
        case .purple: color = UIColor.purple
        case .red: color = UIColor.red
        }
        
        attributes[.strokeWidth] = strokeWidth
        attributes[.strokeColor] = color.withAlphaComponent(alpha)
        attributes[.foregroundColor] = color.withAlphaComponent(alpha)
        
        let attribtext = NSAttributedString(string: string, attributes: attributes)
        
        return attribtext
        
    }
    
    func startGame() {
        cardIsSelected = [Bool]()
        selectedCards = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            
            let attribtext = displayCard(SetCard(number: .three, symbol: .oval, shading: .open, color: .green))
            
            button.setAttributedTitle(attribtext, for: UIControl.State.normal)
            button.layer.borderColor = UIColor.blue.cgColor
            button.layer.borderWidth = 0.0
            button.layer.cornerRadius = 8.0
            cardIsSelected += [false]
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let touchedCard = cardButtons.index(of: sender) {
            
            if selectedCards == 3 && !cardIsSelected[touchedCard] {
                deselectAll()
            }
            
            if cardIsSelected[touchedCard] {
                cardIsSelected[touchedCard] = false
                sender.layer.borderWidth = 0.0
                selectedCards -= 1
            }
            else {
                cardIsSelected[touchedCard] = true
                sender.layer.borderWidth = 3.0
                selectedCards += 1
            }
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        startGame()
    }
    
    @IBAction func dealThree(_ sender: UIButton) {
    }
}

