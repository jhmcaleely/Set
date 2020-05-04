//
//  SetCardView.swift
//  Set
//
//  Created by John McAleely on 03/03/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import UIKit

class SetCardView: UIView {

    override func draw(_ rect: CGRect) {
        let origin = CGPoint(x: 5, y: 5)
        
        drawCard(SetCard(number: SetCard.Number.three,
                         symbol: SetCard.Symbol.diamond,
                         shading: SetCard.Shading.open,
                         color: SetCard.Color.purple),
                 at: origin)
        
        drawCard(SetCard(number: SetCard.Number.two,
                         symbol: SetCard.Symbol.oval,
                         shading: SetCard.Shading.solid,
                         color: SetCard.Color.green),
                 at: origin.applying(CGAffineTransform(translationX: 50, y: 0)))
        
        drawCard(SetCard(number: SetCard.Number.one,
                         symbol: SetCard.Symbol.squiggle,
                         shading: SetCard.Shading.striped,
                         color: SetCard.Color.red),
                 at: origin.applying(CGAffineTransform(translationX: 100, y: 0)))
        
    }
    
    func drawCard(_ card: SetCard, at origin: CGPoint) {
        
        var color: UIColor
        switch card.color {
        case .red: color = UIColor.red
        case .green: color = UIColor.green
        case .purple: color = UIColor.purple
        }

        var symbol: UIBezierPath
        switch card.symbol {
        case .diamond: symbol = diamondPath(at: CGPoint.zero)
        case .oval: symbol = lozengePath(at: CGPoint.zero)
        case .squiggle: symbol = squigglePath(at: CGPoint.zero)
        }
                
        symbol.apply(CGAffineTransform(scaleX: 0.6, y: 0.6))
        color.setFill()
        color.setStroke()
        
        drawCardOutline(at: origin)
        
        var symbolPositions = [CGPoint]()
        if card.number.rawValue == 1 {
            symbolPositions.append(CGPoint(x: 8, y: 19))
        }
        else if card.number.rawValue == 2 {
            symbolPositions.append(CGPoint(x: 8, y: 10))
            symbolPositions.append(CGPoint(x: 8, y: 29))
        }
        else if card.number.rawValue == 3 {
            symbolPositions.append(CGPoint(x: 8, y: 1))
            symbolPositions.append(CGPoint(x: 8, y: 19))
            symbolPositions.append(CGPoint(x: 8, y: 37))
        }
        
        for cursor in symbolPositions {
            let drawnSymbol = symbol.copy() as! UIBezierPath
            drawnSymbol.apply(CGAffineTransform(translationX: cursor.x, y: cursor.y))
            drawnSymbol.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
            
            switch card.shading {
            case .solid:
                drawnSymbol.fill()
            case .open:
                drawnSymbol.lineWidth = 2.5
                drawnSymbol.stroke()
            case .striped:
                drawnSymbol.lineWidth = 2
                drawnSymbol.stroke()

                if let context = UIGraphicsGetCurrentContext() {
                    context.saveGState()
                    drawnSymbol.addClip()
                    
                    let stripes = stripedRectPath(at: CGPoint(x: cursor.x,
                                                              y: cursor.y)
                        .applying(CGAffineTransform(translationX: origin.x,
                                                    y: origin.y)))
                    stripes.lineWidth = 2.5
                    stripes.stroke()
                    
                    context.restoreGState()
                }
            }
        }
    }
    
    func drawCardOutline(at origin: CGPoint) {
        
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()

            let card = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 56)), cornerRadius: 2)
            card.lineWidth = 1.5
            card.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
            UIColor.darkGray.setStroke()
            UIColor.lightGray.setFill()
            card.stroke()
            card.fill()
            
            context.restoreGState()
        }
    }
    
    func stripedRectPath(at origin: CGPoint) -> UIBezierPath {
        
        let stripes = UIBezierPath()
        
        for cursor in 0...13 {
            stripes.addLine(to: CGPoint(x: 40, y: (cursor * 5) - 30))
            stripes.move(to: CGPoint(x: 0, y: cursor * 5))
        }
        
        stripes.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        return stripes
    }
    
    func diamondPath(at origin: CGPoint) -> UIBezierPath {
        
        let diamond = UIBezierPath()
        diamond.move(to: CGPoint(x: 0, y: 15))
        diamond.addLine(to: CGPoint(x: 20, y: 5))
        diamond.addLine(to: CGPoint(x: 40 , y: 15))
        diamond.addLine(to: CGPoint(x: 20, y: 25))
        diamond.close()
        
        diamond.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        return diamond
    }
    
    func lozengePath(at origin: CGPoint) -> UIBezierPath {
        
        let lozenge = UIBezierPath()
        let radius = CGFloat(10.0)
        let length = CGFloat(20.0)
        lozenge.move(to: CGPoint(x: radius + length, y: 5))
        lozenge.addArc(withCenter: CGPoint(x: radius + length, y: 5 + radius), radius: radius, startAngle: 3*CGFloat.pi / 2, endAngle: CGFloat.pi / 2, clockwise: true)
        lozenge.addLine(to: CGPoint(x: radius, y: (2 * radius) + 5))
        lozenge.addArc(withCenter: CGPoint(x: radius, y: 5 + radius), radius: radius, startAngle: CGFloat.pi / 2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        lozenge.close()
        
        lozenge.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        return lozenge
    }
    
    func squigglePath(at origin: CGPoint) -> UIBezierPath {
        let squiggle = UIBezierPath()
        squiggle.move(to: CGPoint(x: 5, y: 10))
        squiggle.addCurve(to: CGPoint(x: 35, y: 10), controlPoint1: CGPoint(x: 15, y: 0), controlPoint2: CGPoint(x:25, y: 20))
        squiggle.addCurve(to: CGPoint(x: 35, y: 20), controlPoint1: CGPoint(x: 40, y: 5), controlPoint2: CGPoint(x: 40, y: 15))
        squiggle.addCurve(to: CGPoint(x: 5, y: 20), controlPoint1: CGPoint(x: 25, y: 30), controlPoint2: CGPoint(x: 15, y: 10))
        squiggle.addCurve(to: CGPoint(x: 5, y: 10), controlPoint1: CGPoint(x: 0, y: 25), controlPoint2:
            CGPoint(x: 0, y: 15))
        
        squiggle.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        return squiggle
    }
}
