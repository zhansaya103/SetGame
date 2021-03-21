//
//  Romb.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-29.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = abs(rect.height - rect.width) > rect.height * 0.25 ? min(rect.height, rect.width) / 3 : rect.height / 4
        let up = CGPoint (
            x: center.x,
            y: center.y - radius * 2
        )
        let right = CGPoint (
            x: center.x + radius,
            y: center.y
        )
        let down = CGPoint (
            x: center.x,
            y: center.y + radius * 2
        )
        let left = CGPoint (
            x: center.x - radius,
            y: center.y
        )
        
        p.move(to: center)
        p.addLines([up, right, down, left, up, right])
        
        return p
    }
    
    
}
