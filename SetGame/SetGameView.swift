//
//  ContentView.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center, spacing: 0){
                Group {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.reset()
                        }
                        
                    }, label: {
                        Text("New Game").bold()
                        
                    })
                }
                .font(Font.system(size: 20))
                .frame(width: geometry.size.width - 20, height: geometry.size.height * 0.03, alignment: .bottomTrailing)
                VStack {
                    withAnimation(.easeInOut(duration: 6)) {
                        Grid(viewModel.cards, viewForItem: { card in
                            CardView(card: card, isFaceUp: true).onTapGesture {
                                withAnimation(.linear(duration: 1)) {
                                    viewModel.choose(card: card)
                                }
                            }
                            .foregroundColor(Color(.systemPurple))
                        })
                        .animation( Animation.linear)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.80, alignment: .bottom)
                .transition(AnyTransition.scale)
                HStack(alignment: .center) {
                    ZStack {
                        ForEach(0..<viewModel.deckCards.count, id: \.self) { index in
                            withAnimation(.easeIn(duration: 3)) {
                                CardView(card:viewModel.deckCards[index], isFaceUp: false)
                                    .position(x: geometry.size.width / 12 + CGFloat((index + 2) * 5), y: geometry.size.height * 0.30 / 3)
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.30)
                    .opacity(viewModel.deckCards.count > 0 ? 1 : 0)
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.20, alignment: .center)
                .foregroundColor(Color(.systemPurple))
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    
    // TODO: anaimation
    //private func startCardsFlyIn() {
    //}
}

struct CardView: View {
    var card: SetGame<CradContent>.Card
    var isFaceUp: Bool
    var body: some View {
        
        GeometryReader { geometry in
            Group {
                switch card.contentShape {
                case Shapes.diamond :
                    if card.contentShading == .solid {
                        ZStack {
                            Group {
                                Diamond()
                                    .stroke(lineWidth: 3)
                                Diamond()
                                    .fill()
                            }
                        }.padding()
                    } else if card.contentShading == .striped {
                        ZStack {
                            Group {
                                Diamond()
                                    .stroke(lineWidth: 3)
                                Diamond()
                                    .fill().opacity(0.3)
                            }
                        }.padding()
                    } else {
                        Diamond()
                            .stroke(lineWidth: 3)
                            .padding()
                    }
                    
                case Shapes.rectangle :
                    if card.contentShading == .solid {
                        ZStack {
                            Group {
                                Rectangle()
                                    .stroke(lineWidth: 3)
                                Rectangle()
                                    .fill()
                            }
                        }.padding()
                    } else if card.contentShading == .striped {
                        ZStack {
                            Group {
                                Rectangle()
                                    .stroke(lineWidth: 3)
                                Rectangle()
                                    .fill().opacity(0.3)
                            }
                        }.padding()
                    } else {
                        Rectangle()
                            .stroke(lineWidth: 3)
                            .padding()
                    }
                    
                case Shapes.oval :
                    if card.contentShading == .solid {
                        ZStack {
                            Group {
                                OvalShape()
                                    .stroke(lineWidth: 3)
                                OvalShape()
                                    .fill()
                            }
                        }.padding()
                    } else if card.contentShading == .striped {
                        ZStack {
                            Group {
                                OvalShape()
                                    .stroke(lineWidth: 3)
                                OvalShape()
                                    .fill().opacity(0.3)
                            }
                        }.padding()
                    } else {
                        OvalShape()
                            .stroke(lineWidth: 3)
                            .padding()
                    }
                }
            }
            .cartify(isSelected: card.isSelected, contentColor: card.contentColor, isMatched: card.isMatched, isChecked: card.isChecked, isFaceUp: isFaceUp)
            .padding(10)
            
        }
    }
    
    func fontSize(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.70
    }
    
    
    
}

enum ContentColor {
    case teal
    case orange
    case pink
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
