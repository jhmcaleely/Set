//
//  CardView.swift
//  Set
//
//  Created by John McAleely on 04/04/2021.
//  Copyright © 2021 John McAleely. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var display = SetCard(number: SetCard.Number.one, symbol: SetCard.Symbol.diamond, shading: SetCard.Shading.open, color: SetCard.Color.green)
    
    override func draw(_ rect: CGRect) {
        let scale = bounds.width / CardGeometry.size.width

        CardView.drawOutline(in: rect)
        
        var color: UIColor
        switch display.color {
        case .red: color = UIColor.red
        case .green: color = UIColor.green
        case .purple: color = UIColor.purple
        }
        color.setFill()
        color.setStroke()
        
        let symbolPositions = CardGeometry.getSymbolPositions(display.number.rawValue)
        
        for cursor in symbolPositions {
            var symbol: UIBezierPath
            switch display.symbol {
            case .diamond: symbol = UIBezierPath(cgPath: CardGeometry.Symbol.diamondPath)
            case .oval: symbol = UIBezierPath(cgPath: CardGeometry.Symbol.lozengePath)
            case .squiggle: symbol = UIBezierPath(cgPath: CardGeometry.Symbol.squigglePath)
            }
            symbol.apply(CGAffineTransform(translationX: cursor.x, y: cursor.y))
            symbol.apply(CGAffineTransform(scaleX: scale, y: scale))
            symbol.apply(CGAffineTransform(translationX: rect.origin.x, y: rect.origin.y))

            CardView.drawSymbol(symbol, with: display.shading, scale: scale)
        }
    }
    
    static func drawOutline(in rect: CGRect) {
        
        let scale = rect.width / CardGeometry.size.width
        let card = UIBezierPath(cgPath: CardGeometry.outlinePath)
        card.apply(CGAffineTransform(scaleX: scale, y: scale))
        card.apply(CGAffineTransform(translationX: rect.origin.x, y: rect.origin.y))
        card.lineWidth = 1.5 * scale
        UIColor.darkGray.setStroke()
        UIColor.lightGray.setFill()
        card.stroke()
        card.fill()
    }
    
    static func drawSymbol(_ symbol: UIBezierPath, with shading: SetCard.Shading, scale: CGFloat) {
        switch shading {
        case .solid:
            symbol.fill()
        case .open:
            symbol.lineWidth = 2.5 * scale
            
            symbol.stroke()
        case .striped:
            symbol.lineWidth = 2 * scale
            
            symbol.stroke()
            
            if let context = UIGraphicsGetCurrentContext() {
                context.saveGState()
                
                let stripes = UIBezierPath(cgPath: CardGeometry.Symbol.stripesPath)
                stripes.apply(CGAffineTransform(scaleX: scale, y: scale))
                stripes.apply(CGAffineTransform(translationX: symbol.bounds.origin.x, y: symbol.bounds.origin.y))
                stripes.lineWidth = 1 * scale
                
                symbol.addClip()
                stripes.stroke()
                
                context.restoreGState()
            }
        }
    }
}
