//
//  Oval.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-29.
//

import SwiftUI

struct OvalShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let newRect = CGRect(x: Int(rect.width / 8), y: Int(rect.height / 8), width: Int(rect.width * 0.75), height: Int(rect.height * 0.75))
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        p.move(to: center)
        p.addEllipse(in: newRect)
        
        return p
    }
}
