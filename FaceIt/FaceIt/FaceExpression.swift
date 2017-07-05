//
//  FaceExpression.swift
//  FaceIt
//
//  Created by Chen Xiaojun on 3/7/17.
//  Copyright © 2017 Lindenbaum Pty Ltd. All rights reserved.
//

import Foundation

// UI-independent representation of a facial expression

struct FacialExpression {
    enum Eyes: Int {
        case open
        case closed
        case squiting
    }
    
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    var eyes: Eyes
    var mouth: Mouth
    
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }
}
