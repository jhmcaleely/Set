//
//  SetCardView.swift
//  Set
//
//  Created by John McAleely on 03/03/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import UIKit

class PlayingSurface: UIView {
    
    var target: Any?
    var action: Selector?
    
    var displayCards: [SetCard] = [SetCard]() {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    var selectedCards: [SetCard]? {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    func growOrShrinkCardViews() {
        if subviews.count < displayCards.count {
            for _ in 0..<displayCards.count - subviews.count {
                let c = CardView()
                let recog = UITapGestureRecognizer(target: target, action: action)
                c.addGestureRecognizer(recog)
                c.isOpaque = false
                addSubview(c)
            }
        }
        else if subviews.count > displayCards.count {
            for _ in 0..<(subviews.count - displayCards.count) {
                subviews.last?.removeFromSuperview()
            }
        }
    }
      
    override func layoutSubviews() {
        var cardGrid = Grid(layout: Grid.Layout.aspectRatio(5 / 7), frame: bounds)
        cardGrid.cellCount = displayCards.count
   
        growOrShrinkCardViews()
                
        for i in 0..<displayCards.count {
            let gridRect = cardGrid[i] ?? CGRect.zero
            let cardView = subviews[i] as! CardView
            
            cardView.card = displayCards[i]
            subviews[i].frame = gridRect
            
            if let selection = selectedCards {
                cardView.isSelected = selection.firstIndex(of: displayCards[i]) != nil
                cardView.setNeedsDisplay()
            }
        }
    }
    

    
    override func draw(_ rect: CGRect) {
        

    }
}
