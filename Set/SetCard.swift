//
//  SetCard.swift
//  Set
//
//  Created by John McAleely on 02/01/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import Foundation

struct SetCard
{
    enum Number : CaseIterable {
        case one
        case two
        case three
    }
    
    enum Symbol : CaseIterable {
        case diamond
        case squiggle
        case oval
    }
    
    enum Shading : CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Color : CaseIterable {
        case red
        case green
        case purple
    }
    
    let number : Number
    let symbol : Symbol
    let shading : Shading
    let color : Color
}
