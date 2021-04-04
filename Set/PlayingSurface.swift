//
//  SetCardView.swift
//  Set
//
//  Created by John McAleely on 03/03/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import UIKit

class PlayingSurface: UIView {
    
    var displayCards: [SetCard] = [SetCard]() {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var displayViews: [CardView] = [CardView]()
    
    override func layoutSubviews() {
        var cardGrid = Grid(layout: Grid.Layout.aspectRatio(5 / 7), frame: bounds)
        cardGrid.cellCount = displayCards.count
        
        if displayViews.count < displayCards.count {
            for _ in 0..<(displayCards.count - displayViews.count) {
                let c = CardView()
                c.isOpaque = false
                displayViews.append(c)
                addSubview(c)
            }
        }
        else if displayViews.count > displayCards.count {
            for _ in 0..<(displayViews.count - displayCards.count) {
                let c = displayViews.removeLast()
                c.removeFromSuperview()
            }
        }
        
        for card in 0..<displayCards.count {
            let gridRect = cardGrid[card] ?? CGRect.zero
            let cardRect = gridRect.inset(by: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
            
            displayViews[card].display = displayCards[card]
            displayViews[card].frame = cardRect
        }

    }
    

    
    override func draw(_ rect: CGRect) {
        

    }
}
