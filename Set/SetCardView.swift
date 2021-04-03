//
//  SetCardView.swift
//  Set
//
//  Created by John McAleely on 03/03/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    
    var displayCards: [SetCard] = [SetCard]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    class Card {
        static func draw(_ card: SetCard, at position: CGPoint) {
            
            drawOutline(at: position)
            
            var color: UIColor
            switch card.color {
            case .red: color = UIColor.red
            case .green: color = UIColor.green
            case .purple: color = UIColor.purple
            }
            color.setFill()
            color.setStroke()
            
            let symbolPositions = CardGeometry.getSymbolPositions(card.number.rawValue)
            
            for cursor in symbolPositions {
                var symbol: UIBezierPath
                switch card.symbol {
                case .diamond: symbol = UIBezierPath(cgPath: CardGeometry.Symbol.diamondPath)
                case .oval: symbol = UIBezierPath(cgPath: CardGeometry.Symbol.lozengePath)
                case .squiggle: symbol = UIBezierPath(cgPath: CardGeometry.Symbol.squigglePath)
                }
                symbol.apply(CGAffineTransform(translationX: position.x, y: position.y))
                symbol.apply(CGAffineTransform(translationX: cursor.x, y: cursor.y))
                
                drawSymbol(symbol, with: card.shading)
            }
        }
        
        static func drawOutline(at position: CGPoint) {
            
            if let context = UIGraphicsGetCurrentContext() {
                context.saveGState()
                
                let card = UIBezierPath(cgPath: CardGeometry.outlinePath)
                card.apply(CGAffineTransform(translationX: position.x, y: position.y))
                card.lineWidth = 1.5
                UIColor.darkGray.setStroke()
                UIColor.lightGray.setFill()
                card.stroke()
                card.fill()
                
                context.restoreGState()
            }
        }
        
        static func drawSymbol(_ symbol: UIBezierPath, with shading: SetCard.Shading) {
            switch shading {
            case .solid:
                symbol.fill()
            case .open:
                symbol.lineWidth = 2.5
                
                symbol.stroke()
            case .striped:
                symbol.lineWidth = 2
                
                symbol.stroke()
                
                if let context = UIGraphicsGetCurrentContext() {
                    context.saveGState()
                    
                    let stripes = UIBezierPath(cgPath: CardGeometry.Symbol.stripesPath)
                    stripes.apply(CGAffineTransform(translationX: symbol.bounds.origin.x, y: symbol.bounds.origin.y))
                    stripes.lineWidth = 1
                    
                    symbol.addClip()
                    stripes.stroke()
                    
                    context.restoreGState()
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        var cardGrid = Grid(layout: Grid.Layout.aspectRatio(5 / 7), frame: bounds)
        cardGrid.cellCount = displayCards.count
        
        var x = 0
        for card in displayCards {
            Card.draw(card, in: cardGrid[x] ?? CGRect.zero)
            x = x + 1
        }
        
        
    }
}
