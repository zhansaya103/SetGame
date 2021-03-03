//
//  ButtonModifier.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-03-01.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
   
    var disabled: Bool
    
    func body(content: Content) -> some View {
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 3.0).blur(radius: 4.0).brightness(disabled ? 0 : 0.9)
                content
            }
        }
    }
}

extension View {
    func modify(disabled: Bool) -> some View {
        self.modifier(ButtonModifier(disabled: disabled))
    }
}
