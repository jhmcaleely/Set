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
        drawCard(SetCard(number: SetCard.Number.three,
                         symbol: SetCard.Symbol.diamond,
                         shading: SetCard.Shading.solid,
                         color: SetCard.Color.red),
                 at: CGPoint(x: 5, y: 5))
    }
    
    func drawCard(_ card: SetCard, at origin: CGPoint) {
        UIColor.red.setFill()
        UIColor.red.setStroke()
        drawSolidCard(at: origin)
        
        // actually draws three cards for now.
        drawOutlineCard(at: origin.applying(CGAffineTransform(translationX: 50, y: 0)))
        drawStripedCard(at: origin.applying(CGAffineTransform(translationX: 100, y: 0)))
    }

    func drawOutlineCard(at origin: CGPoint) {
        let symbol = lozengePath(at: CGPoint.zero)
        symbol.apply(CGAffineTransform(scaleX: 0.6, y: 0.6))
        
        let symbol1Position = CGPoint(x: 8, y: 1)
        let symbol2Position = CGPoint(x: 8, y: 19)
        let symbol3Position = CGPoint(x: 8, y: 37)
        
        drawOutlineSymbol(symbol: symbol, at: symbol1Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))
        drawOutlineSymbol(symbol: symbol, at: symbol2Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))
        drawOutlineSymbol(symbol: symbol, at: symbol3Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))

        drawCardOutline(at: origin)
    }

    func drawSolidCard(at origin: CGPoint) {
        let symbol = diamondPath(at: CGPoint.zero)
        symbol.apply(CGAffineTransform(scaleX: 0.6, y: 0.6))
        
        let symbol1Position = CGPoint(x: 8, y: 1)
        let symbol2Position = CGPoint(x: 8, y: 19)
        let symbol3Position = CGPoint(x: 8, y: 37)
        
        drawSolidSymbol(symbol: symbol, at: symbol1Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))
        drawSolidSymbol(symbol: symbol, at: symbol2Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))
        drawSolidSymbol(symbol: symbol, at: symbol3Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))

        drawCardOutline(at: origin)
    }
    
    func drawStripedCard(at origin: CGPoint) {
        let symbol = squigglePath(at: CGPoint.zero)
        symbol.apply(CGAffineTransform(scaleX: 0.6, y: 0.6))
        
        let symbol1Position = CGPoint(x: 8, y: 1)
        let symbol2Position = CGPoint(x: 8, y: 19)
        let symbol3Position = CGPoint(x: 8, y: 37)
        
        drawStripedSymbol(symbol: symbol, at: symbol1Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))
        drawStripedSymbol(symbol: symbol, at: symbol2Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))
        drawStripedSymbol(symbol: symbol, at: symbol3Position.applying(CGAffineTransform(translationX: origin.x, y: origin.y)))

        drawCardOutline(at: origin)
    }
    
    func drawCardOutline(at origin: CGPoint) {
        let card = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 56)), cornerRadius: 2)
        card.lineWidth = 1.5
        card.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        card.stroke()
    }
    
    func drawOutlineSymbol(symbol: UIBezierPath, at origin: CGPoint) {
        let drawnSymbol = symbol.copy() as! UIBezierPath
        
        drawnSymbol.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        drawnSymbol.lineWidth = 2.5
        drawnSymbol.stroke()
    }
    
    func drawSolidSymbol(symbol: UIBezierPath, at origin: CGPoint) {
        let drawnSymbol = symbol.copy() as! UIBezierPath
        drawnSymbol.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        drawnSymbol.fill()
    }
    
    func drawStripedSymbol(symbol: UIBezierPath, at origin: CGPoint) {
        
        let drawnSymbol = symbol.copy() as! UIBezierPath
        drawnSymbol.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        drawnSymbol.lineWidth = 2
        drawnSymbol.stroke()

        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            drawnSymbol.addClip()
            
            let stripes = stripedRectPath(at: CGPoint(x: origin.x , y: origin.y))
            stripes.lineWidth = 2.5
            stripes.stroke()
            
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
