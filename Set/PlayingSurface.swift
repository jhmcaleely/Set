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
        willSet {
            growOrShrinkCardViews(to: newValue.count)
        }
        
        didSet {
            for i in 0..<subviews.count {
                let cardView = subviews[i] as! CardView
                cardView.card = displayCards[i]
                cardView.setNeedsDisplay()
            }
            setNeedsDisplay()
        }
    }
    
    var selectedCards: [SetCard]? {
        didSet {
            if let selection = selectedCards {
                for i in 0..<subviews.count {
                    let cardView = subviews[i] as! CardView
                    cardView.isSelected = selection.firstIndex(of: cardView.card!) != nil
                    cardView.setNeedsDisplay()
                }
            }
            else {
                for i in 0..<subviews.count {
                    let cardView = subviews[i] as! CardView
                    cardView.isSelected = false
                    cardView.setNeedsDisplay()
                }
            }
            setNeedsDisplay()
        }
    }
    
    func growOrShrinkCardViews(to newcount: Int) {
        if subviews.count < newcount {
            for _ in 0..<newcount - subviews.count {
                let c = CardView()
                let recog = UITapGestureRecognizer(target: target, action: action)
                c.addGestureRecognizer(recog)
                c.isOpaque = false
                addSubview(c)
            }
            setNeedsLayout()
        }
        else if subviews.count > newcount {
            for _ in 0..<(subviews.count - newcount) {
                subviews.last?.removeFromSuperview()
            }
            setNeedsLayout()
        }
    }
      
    override func layoutSubviews() {
        var cardGrid = Grid(layout: Grid.Layout.aspectRatio(5 / 7), frame: bounds)
        cardGrid.cellCount = subviews.count
  
        for i in 0..<subviews.count {
            let gridRect = cardGrid[i] ?? CGRect.zero
            subviews[i].frame = gridRect
        }
    }
}
