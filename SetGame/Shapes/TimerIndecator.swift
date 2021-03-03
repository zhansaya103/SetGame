//
//  TimerIndecator.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-03-02.
//

import SwiftUI

struct TimerIndicator: Shape {
    var startWidth = CGFloat()
    //var endWidth = CGFloat()
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(startWidth, 0)
        }
        set {
            startWidth = newValue.first
            //endWidth = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let newRect = CGRect(x: rect.maxX, y: rect.maxY, width: startWidth, height: rect.height)
        p.move(to: center)
        p.addRoundedRect(in: rect, cornerSize: CGSize(width: newRect.width , height: rect.height / 40))
       
        return p
    }
}

