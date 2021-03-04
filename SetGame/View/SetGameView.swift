//
//  ContentView.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    @State var animatedBonusRemaining: Double = 0
    @State var inidcColor = Color.init(.sRGB, red: 0.263, green: 0.839, blue: 0.590, opacity: 1)
    @State var timeLimit: TimeInterval = 30
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack (alignment: .bottom, spacing: 0) {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 5) {
                        HStack {
                            Group {
                                ZStack {
                                    TimerIndicator(startWidth: geometry.size.width / 2)
                                        .fill(inidcColor)
                                    TimerIndicator(startWidth: geometry.size.width / 2)
                                        .stroke(lineWidth: 4.0).blur(radius: 3.0).brightness(0.40)
                                }
                                .cornerRadius(5)
                                //.frame(width: geometry.size.width / (CGFloat(46 - timeLimit) * 2 ), height: 30)
                                .frame(width: geometry.size.width / (2 * CGFloat(animatedBonusRemaining + 1)), height: 30)
                                .padding()
                                .onAppear {
                                    self.startBonusTimeAnimation()
                                    
                                }
                            }
                            .frame(width: geometry.size.width * 0.60, height: 30, alignment: .leading)
                            HStack {
                                ResetButtonView(viewModel: viewModel, geometry: geometry, animatedBonusRemaining: $animatedBonusRemaining, inidcColor: $inidcColor, timeLimit: $timeLimit)
                                    .padding()
                            }
                            .frame(width: geometry.size.width * 0.40, height: 30, alignment: .trailing)
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 30, alignment: .leading)
                        
                        MainGameField(viewModel: viewModel, geometry: geometry)
                            .disabled(viewModel.isChecking)
                        
                        HStack {
                            Button(action: {
                                
                                viewModel.check()
                                viewModel.getRemainingSeconds(timeLimit)
                            }) {
                                Text("Check")
                            }
                            .foregroundColor(Color(.white))
                            .disabled( withAnimation(.easeInOut) {
                                viewModel.selectedCards.count == 3 ? false : true
                                
                            })
                            .modify(disabled: viewModel.selectedCards.count == 3)
                            .animation(viewModel.selectedCards.count == 3 ? Animation.interpolatingSpring(stiffness: 2, damping: 0) : .default)
                        }
                        .font(Font.system(size: 30))
                        .background(Color(.orange))
                        .cornerRadius(5)
                        .opacity(viewModel.selectedCards.count == 3 ? 1 : 0.5)
                        .frame(width: geometry.size.width / 2, height: 50, alignment: .center)
                        
                        HStack {
                            DeckCardsView( viewModel: viewModel, geometry: geometry)
                                .frame(width: geometry.size.width / 2, alignment: .center)
                            ZStack {
                                HStack(alignment: .center) {
                                    Text("\(viewModel.score)").font(Font.system(size: 50)).bold()
                                }
                                Text(viewModel.isThreeMatched ? "+5" : "-5").font(Font.system(size: 30))
                                    .frame(width: geometry.size.width / 2, alignment: .center)
                                    .opacity(viewModel.selectedCards.count == 3 ? 1 : 0)
                                    .rotationEffect(Angle.degrees(viewModel.selectedCards.count == 3 ? 360 : 0))
                                    .offset(x: 0, y: viewModel.selectedCards.count == 3 ? -50 : 0)
                                    .animation(Animation.interpolatingSpring(stiffness: 1, damping: 1).delay(0.8))
                            }
                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 8, alignment: .bottom)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(.white))
                            //.border(Color(.black))
                        }
                    }
                    .disabled(viewModel.gameOver)
                    .opacity(viewModel.gameOver ? 0.50: 1)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    VStack(spacing: 20) {
                        
                        Text("Score: \(viewModel.score)\nTime bonus: +\(viewModel.bonus)\nTotal: \(viewModel.score + viewModel.bonus)")
                            .modify(disabled: viewModel.gameOver)
                            .background(Color("gameOverLabel"))
                            .layoutPriority(1)
                            .cornerRadius(5)
                        Button(action: {
                            withAnimation(.easeInOut(duration: 1)) {
                                viewModel.reset()
                                animatedBonusRemaining = 0
                                inidcColor = Color.init(.sRGB, red: 0.263, green: 0.839, blue: 0.590, opacity: 1)
                                timeLimit = viewModel.bonusTimeLimit
                                startBonusTimeAnimation()
                                
                                
                            }
                        }, label: {
                            Text("New Game")
                            
                        })
                        .modify(disabled: viewModel.gameOver)
                        .animation(viewModel.gameOver ? Animation.interpolatingSpring(stiffness: 2, damping: 0) : .default)
                        .background(Color("newGameButton"))
                        .frame(minHeight: 35)
                        .cornerRadius(5)
                        
                    }
                    .foregroundColor(Color(.white))
                    .font(Font.system(size: 20))
                    
                    .opacity(viewModel.gameOver ? 1 : 0)
                    .frame(width: geometry.size.width * 0.80, height: 200, alignment: .center)
                    .offset(x: 0, y: -30)
                }
                
            }
        }
        .onAppear {
            timeLimit = viewModel.bonusTimeLimit
        }
        .onReceive(timer) { _ in
            guard viewModel.cards.count > 0 else { return }
            timeLimit -= 1
            if Int(timeLimit) == 0 {
                viewModel.getRemainingSeconds(timeLimit)
            }
        }
        .background(Color("fieldBackground"))
        .ignoresSafeArea(edges: .all)
        
        
    }
    
    
    
    
    func startBonusTimeAnimation() {
        
        withAnimation(.linear(duration: viewModel.bonusTimeLimit)) {
            timeLimit -= 1
            animatedBonusRemaining = 20
            inidcColor = Color.init(.sRGB, red: 0.263 * ((animatedBonusRemaining + 1) / 4 ), green: 0.839 / (animatedBonusRemaining + 1), blue: 0.590 / ((animatedBonusRemaining + 1) * 5), opacity: 1)
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



struct ResetButtonView: View {
    var viewModel: SetGameViewModel
    var geometry: GeometryProxy
    @Binding var animatedBonusRemaining: Double
    @Binding var inidcColor: Color
    @Binding var timeLimit: TimeInterval
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 1)) {
                viewModel.reset()
                animatedBonusRemaining = 0
                inidcColor = Color.init(.sRGB, red: 0.263, green: 0.839, blue: 0.590, opacity: 1)
                timeLimit = viewModel.bonusTimeLimit
                startBonusTimeAnimation()
                
                
            }
        }, label: {
            Text("New Game").bold()
            
        })
        .font(Font.system(size: 20))
        .foregroundColor(Color(.white))
    }
    
    func startBonusTimeAnimation() {
        withAnimation(.linear(duration: viewModel.bonusTimeLimit)) {
            animatedBonusRemaining = 20
            inidcColor = Color.init(.sRGB, red: 0.263 * ((animatedBonusRemaining + 1) / 4 ), green: 0.839 / (animatedBonusRemaining + 1), blue: 0.590 / ((animatedBonusRemaining + 1) * 5), opacity: 1)
        }
    }
}

struct DeckCardsView: View {
    var viewModel: SetGameViewModel
    var geometry: GeometryProxy
    var body: some View {
        
        ZStack {
            ForEach(0..<viewModel.deckCards.count, id: \.self) { index in
                withAnimation(.easeIn(duration: 3)) {
                    CardView(card:viewModel.deckCards[index], isFaceUp: false)
                        .position(x: geometry.size.width / 12 + CGFloat((index + 2) * 5), y: geometry.size.height * 0.30 / 3)
                }
            }
        }
        .frame(width: geometry.size.width * 0.30, height: geometry.size.height * 0.15, alignment: .bottom)
        .opacity(viewModel.deckCards.count > 0 ? 1 : 0)
        .position(x: geometry.size.width / 2, y: geometry.size.height / 20)
        .frame(width: geometry.size.width, height: geometry.size.height * 0.10, alignment: .bottom)
        .foregroundColor(Color("cardDeck"))
        .animation(viewModel.selectedCards.count == 3 ? Animation.interpolatingSpring(stiffness: 2, damping: 0) : .default)
        
    }
}

struct MainGameField: View {
    var viewModel: SetGameViewModel
    var geometry: GeometryProxy
    var body: some View {
        VStack(spacing: 5) {
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
        .frame(width: geometry.size.width, height: geometry.size.height * 0.65, alignment: .bottom)
        .transition(AnyTransition.scale)
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = SetGameViewModel()
        SetGameView(viewModel: viewModel)
    }
}
