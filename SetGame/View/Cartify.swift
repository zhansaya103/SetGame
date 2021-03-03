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
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color(isSelected ? .white : UIColor(Color("mildGray"))))
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: isSelected ? 4.0 : 3.0).blur(radius: isSelected ? 4.0 : 0).brightness(0.80)
                    if let isMatched = self.isMatched {
                        Group {
                            if isMatched {
                                
                                RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.green)).opacity(0.10).brightness(0.80)
                                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3.0 ).foregroundColor(Color(.green)).blur(radius: 4).brightness(0.80)
                                
                            } else {
                                RoundedRectangle(cornerRadius: cornerRadius).fill(Color(.red)).opacity(0.10).brightness(0.80)
                                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: 3.0 ).foregroundColor(Color(.red)).blur(radius: 4).brightness(0.80)
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

