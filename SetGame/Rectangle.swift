//
//  Rectangle.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-29.
//

import SwiftUI

struct Rectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = abs(rect.height - rect.width) > rect.height * 0.25 ? min(rect.height, rect.width) / 3 : rect.height / 4
        let topleft = CGPoint (
            x: center.x - radius,
            y: center.y - radius * 2
        )
        let topRight = CGPoint (
            x: center.x + radius,
            y: center.y - radius * 2
        )
        let downLeft = CGPoint (
            x: center.x - radius,
            y: center.y + radius * 2
        )
        let downRight = CGPoint (
            x: center.x + radius,
            y: center.y + radius * 2
        )
        
        p.move(to: center)
        p.addLines([topleft, topRight, downRight, downLeft, topleft])
        
        return p
    }
}
