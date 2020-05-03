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

        let diamond = diamondPath(at: CGPoint.zero)
        let lozenge = lozengePath(at: CGPoint.zero)
        let squiggle = squigglePath(at: CGPoint.zero)
        
        UIColor.red.setFill()
        UIColor.red.setStroke()
        
 //       drawStripedSymbol(symbol: diamond, at: CGPoint(x: 5, y: 5))
 //       drawStripedSymbol(symbol: squiggle, at: CGPoint(x: 5, y: 35))
 //       drawStripedSymbol(symbol: lozenge, at: CGPoint(x: 5, y: 65))
        
        drawSolidSymbol(symbol: diamond, at: CGPoint(x: 50, y: 5))
        drawSolidSymbol(symbol: squiggle, at: CGPoint(x: 50, y: 35))
        drawSolidSymbol(symbol: lozenge, at: CGPoint(x: 50, y: 65))
        
        drawOutlineSymbol(symbol: diamond, at: CGPoint(x: 100, y: 5))
        drawOutlineSymbol(symbol: squiggle, at: CGPoint(x: 100, y: 35))
        drawOutlineSymbol(symbol: lozenge, at: CGPoint(x: 100, y: 65))
        
        drawCard()
    }
    
    func drawCard() {
        let card = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 56)), cornerRadius: 2)
        
        let diamond = squigglePath(at: CGPoint.zero)
        diamond.apply(CGAffineTransform(scaleX: 0.6, y: 0.6))
        
        drawStripedSymbol(symbol: diamond, at: CGPoint(x: 8, y: 1))
        drawStripedSymbol(symbol: diamond, at: CGPoint(x: 8, y: 19))
        drawStripedSymbol(symbol: diamond, at: CGPoint(x: 8, y: 37))

        card.lineWidth = 1
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
        drawnSymbol.lineWidth = 1.5
        let stripes = stripedRectPath(at: CGPoint(x: origin.x , y: origin.y))
        
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            drawnSymbol.stroke()
            drawnSymbol.addClip()
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
