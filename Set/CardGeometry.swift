//
//  CardGeometry.swift
//  Set
//
//  Created by John McAleely on 03/04/2021.
//  Copyright © 2021 John McAleely. All rights reserved.
//

import CoreGraphics

// Card and Symbol Geometry
//
// Nominal Card Aspect Ratio: 5:7 (cf poker card size of 2.5in x 3.5in)
// Nominal Symbol Aspect 4:3 (arbitrary choice)
// Nominal Card Size: 40x56
// Nominal Symbol Size: 24x18
// Nominal design grid for Symbols: 3
// See CardGeometry.pdf for more details


class CardGeometry {
    
    static let size = CGSize(width: 40, height: 56)
    
    static func getSymbolPositions(_ symbols: Int) -> [CGPoint] {
        var positions = [CGPoint]()
        
        let symbolX = size.width / 2 - Symbol.size.width / 2
        let vOffset = CGFloat(1)
        
        if symbols == 1 {
            positions.append(CGPoint(x: symbolX, y: vOffset + Symbol.size.height))
        }
        else if symbols == 2 {
            let vOffset = vOffset + Symbol.size.height / 2
            positions.append(CGPoint(x: symbolX, y: vOffset))
            positions.append(CGPoint(x: symbolX, y: vOffset + Symbol.size.height))
        }
        else if symbols == 3 {
            positions.append(CGPoint(x: symbolX, y: vOffset))
            positions.append(CGPoint(x: symbolX, y: vOffset + Symbol.size.height))
            positions.append(CGPoint(x: symbolX, y: vOffset + Symbol.size.height + Symbol.size.height))
        }
        return positions
    }
    
    static var outlinePath: CGPath {
        get {
            return CGPath(roundedRect: CGRect(origin: CGPoint.zero,
                                              size: size),
                          cornerWidth: CGFloat(Symbol.grid),
                          cornerHeight: CGFloat(Symbol.grid),
                          transform: nil)
        }
    }
    
    class Symbol {
        
        static let grid = 3
        static let size = CGSize(width: 8 * grid, height: 6 * grid)
        
        static var stripesPath: CGPath {
            get {
                let stripeSpacing = grid
                let noStripes = (Int(size.height) / stripeSpacing) - 1
                
                let stripes = CGMutablePath()
                for cursor in 0...noStripes {
                    let yCursor = CGFloat(cursor) * CGFloat(stripeSpacing)
                    stripes.addLine(to: CGPoint(x: size.width, y: yCursor - (2 * CGFloat(stripeSpacing))))
                    stripes.move(to: CGPoint(x: 0, y: yCursor))
                }
                return stripes
            }
        }
        
        static var diamondPath: CGPath {
            get {
                let verticalOffset = CGFloat(grid)
                let size = CGSize(width: Symbol.size.width, height: Symbol.size.width / 2)
                let center = CGPoint(x: size.width / 2, y: verticalOffset + size.height / 2)
                
                let diamond = CGMutablePath()
                diamond.move(to: CGPoint(x: 0, y: center.y))
                diamond.addLine(to: CGPoint(x: center.x, y: verticalOffset))
                diamond.addLine(to: CGPoint(x: size.width , y: center.y))
                diamond.addLine(to: CGPoint(x: center.x, y: verticalOffset + size.height))
                diamond.closeSubpath()
                
                return diamond
            }
        }
        
        static var lozengePath: CGPath {
            get {
                let verticalOffset = CGFloat(grid)
                let radius = CGFloat(2 * grid)
                let width = size.width
                let bodyWidth = width - 2 * radius
                
                let lozenge = CGMutablePath()
                lozenge.move(to: CGPoint(x: radius + bodyWidth, y: verticalOffset))
                lozenge.addArc(center: CGPoint(x: radius + bodyWidth, y: verticalOffset + radius),
                               radius: radius,
                               startAngle: 3 * CGFloat.pi / 2,
                               endAngle: CGFloat.pi / 2,
                               clockwise: false)
                lozenge.addLine(to: CGPoint(x: radius, y: (2 * radius) + verticalOffset))
                lozenge.addArc(center: CGPoint(x: radius, y: verticalOffset + radius),
                               radius: radius,
                               startAngle: CGFloat.pi / 2,
                               endAngle: 3 * CGFloat.pi / 2,
                               clockwise: false)
                lozenge.closeSubpath()
                
                return lozenge
            }
        }
        
        static var squigglePath: CGPath {
            get {
                let squiggle = CGMutablePath()
                squiggle.move(to: CGPoint(x: grid, y: 2 * grid))
                squiggle.addCurve(to: CGPoint(x: 7 * grid, y: 2 * grid),
                                  control1: CGPoint(x: 3 * grid, y: 0),
                                  control2: CGPoint(x: 5 * grid, y: 4 * grid))
                squiggle.addCurve(to: CGPoint(x: 7 * grid, y: 4 * grid),
                                  control1: CGPoint(x: 8 * grid, y: grid),
                                  control2: CGPoint(x: 8 * grid, y: 3 * grid))
                squiggle.addCurve(to: CGPoint(x: grid, y: 4 * grid),
                                  control1: CGPoint(x: 5 * grid, y: 6 * grid),
                                  control2: CGPoint(x: 3 * grid, y: 2 * grid))
                squiggle.addCurve(to: CGPoint(x: grid, y: 2 * grid),
                                  control1: CGPoint(x: 0, y: 5 * grid),
                                  control2: CGPoint(x: 0, y: 3 * grid))
                
                return squiggle
            }
        }
    }
}

