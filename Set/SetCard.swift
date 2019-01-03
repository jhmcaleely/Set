//
//  SetCard.swift
//  Set
//
//  Created by John McAleely on 02/01/2019.
//  Copyright © 2019 John McAleely. All rights reserved.
//

import Foundation

struct SetCard: Equatable
{
    enum Number : Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Symbol : CaseIterable {
        case diamond, squiggle, oval
    }
    
    enum Shading : CaseIterable {
        case solid, striped, open
    }
    
    enum Color : CaseIterable {
        case red, green, purple
    }
    
    let number : Number
    let symbol : Symbol
    let shading : Shading
    let color : Color
}
