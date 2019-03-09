//
//  SetCardView.swift
//  Set
//
//  Created by John McAleely on 03/03/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import UIKit

class SetCardView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        let diamond = UIBezierPath()
        diamond.move(to: CGPoint(x: 5, y: bounds.midY))
        diamond.addLine(to: CGPoint(x: bounds.midX, y: (bounds.maxY / 4) * 3))
        diamond.addLine(to: CGPoint(x: bounds.maxX - 5 , y: bounds.midY))
        diamond.addLine(to: CGPoint(x: bounds.midX, y: (bounds.maxY / 4)))
        diamond.close()
        diamond.lineWidth = 5.0
        
        let lozenge = UIBezierPath()
        let radius = CGFloat(10.0)
        let length = CGFloat(40.0)
        lozenge.move(to: CGPoint(x: radius + length, y: 0))
        lozenge.addArc(withCenter: CGPoint(x: radius + length, y: 0 + radius), radius: radius, startAngle: 3*CGFloat.pi / 2, endAngle: CGFloat.pi / 2, clockwise: true)
        lozenge.addLine(to: CGPoint(x: radius, y: 2 * radius))
        lozenge.addArc(withCenter: CGPoint(x: radius, y: 0 + radius), radius: radius, startAngle: CGFloat.pi / 2, endAngle: 3*CGFloat.pi / 2, clockwise: true)
        lozenge.close()
        lozenge.lineWidth = 5.0
        
        
        UIColor.green.setFill()
        UIColor.red.setStroke()
        diamond.stroke()
        diamond.fill()
        lozenge.stroke()
        lozenge.fill()
    }
}
