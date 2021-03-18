//
//  SetGameViewmodel.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    @Published private var model: SetGame<CradContent>
    
    static func createSetGame() -> SetGame<CradContent> {
        var cardContentList: [CradContent] = []
        for shape in Shapes.allCases {
            for shading in Shading.allCases {
                for color in ContentColor.allCases {
                    cardContentList.append(CradContent(shape: shape, color: color, shading: shading))
                }
            }
        }
    
        
        return SetGame<CradContent>(numberOfCards: cardContentList.count) { index in
            cardContentList[index]}
    }
    
    init() {
        self.model = SetGameViewModel.createSetGame()
    }
    
    var cards: Array<SetGame<CradContent>.Card> {
        var twelveCards: [SetGame<CradContent>.Card] = []
        if self.model.cards.count > 12 {
            for i in 0..<12 {
                twelveCards.append(self.model.cards[i])
            }
            return twelveCards
        } else {
            return self.model.cards
        }
    }
    
    var deckCards: Array<SetGame<CradContent>.Card> {
        var remainCards: [SetGame<CradContent>.Card] = []
        if self.model.cards.count > 12 {
            for i in 12..<self.model.cards.count {
                remainCards.append(self.model.cards[i])
            }
        }
        
        return remainCards
    }
    
    func choose(card: SetGame<CradContent>.Card) {
        model.choose(card: card)
    }
    
    func reset() {
        self.model = SetGameViewModel.createSetGame()
    }
    
    var isThreeMatched: Bool {
        model.isThreeMatched
    }
    
    var selectedCards: [SetGame<CradContent>.Card] {
        return model.selectedCards
    }
    
    func check() {
        self.model.check()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.model.unSelect()
        }
    }
    
    func getRemainingSeconds(_ remainingSeconds: TimeInterval) {
        self.model.getRemainingTime(remainingSeconds)
    }
    
    var bonusTimeLimit: TimeInterval {
        self.model.bonusTimeLimit
    }
    
    var score: Int {
        self.model.score
    }
    
    var bonus: Int {
        self.model.bonus
    }
    
    var gameOver: Bool {
        self.model.gameOver
    }
    
    var isChecking: Bool {
        self.model.isChecking
    }
}

struct CradContent {
    var shape: Shapes
    var color: ContentColor
    var shading: Shading
}

enum Shapes: CaseIterable {
    case diamond
    case rectangle
    case oval
}

enum Shading: CaseIterable {
    case solid
    case striped
    case empty
}
