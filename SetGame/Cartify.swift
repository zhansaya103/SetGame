//
//  Cartify.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import SwiftUI

struct Cartify: ViewModifier {
    var isSelected: Bool
    var contentColor: ContentColor
    var isMatched: Bool?
    var isChecked: Bool = false
    var isFaceUp: Bool
    init(isSelected: Bool, contentColor: ContentColor, isMatched: Bool?, isChecked: Bool, isFaceUp: Bool) {
        self.isSelected = isSelected
        self.contentColor = contentColor
        self.isMatched = isMatched
        self.isChecked = isChecked
        self.isFaceUp = isFaceUp
    }
    
    var color : Color {
        switch contentColor {
            case .teal: return Color(.systemTeal)
            case .pink: return Color(.systemPink)
            case .orange: return Color(.systemOrange)
        }
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            if isFaceUp {
                Group {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color(isSelected ? #colorLiteral(red: 0.8007984757, green: 0.8062334657, blue: 1, alpha: 0.5) : .white))
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: isSelected ? 3.0 : 2.0).blur(radius: isSelected ? 4.0 : 0)
                    if let isMatched = self.isMatched {
                        Group {
                        if isMatched {
                            
                                RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.green)).opacity(0.15)
                                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3.0 ).foregroundColor(Color(.green)).blur(radius: 4)
                            
                        } else {
                            RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.red)).opacity(0.15)
                            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3.0 ).foregroundColor(Color(.red)).blur(radius: 4)
                        }
                        }.opacity(isChecked ? 1 : 0)
                    }
                    content
                        .foregroundColor(color)
                }
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
                RoundedRectangle(cornerRadius: cornerRadius).stroke().foregroundColor(Color(.white))
                    .rotation3DEffect(Angle.degrees(isSelected ? 180 : 0), axis: (0, 1, 0))
            }
            
        }
    }
    
    let cornerRadius: CGFloat = 10.0
    let lineWidth: CGFloat = 2.0
    
}
extension View {
    func cartify(isSelected: Bool, contentColor: ContentColor, isMatched: Bool?, isChecked: Bool, isFaceUp: Bool) -> some View {
        self.modifier(Cartify(isSelected: isSelected, contentColor: contentColor, isMatched: isMatched, isChecked: isChecked, isFaceUp: isFaceUp))
    }
}

