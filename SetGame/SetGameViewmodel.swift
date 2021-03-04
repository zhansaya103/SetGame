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
       
        let cardContentEmptyD = CradContent(shape: .diamond, color: .orange, shading: .empty)
        let cardContentEmptyR = CradContent(shape: .rectangle, color: .orange, shading: .empty)
        let cardContentEmptyO = CradContent(shape: .oval, color: .orange, shading: .empty)
        let cardContentEmptyDD = CradContent(shape: .diamond, color: .teal, shading: .empty)
        let cardContentEmptyRR = CradContent(shape: .rectangle, color: .teal, shading: .empty)
        let cardContentEmptyOO = CradContent(shape: .oval, color: .teal, shading: .empty)
        let cardContentEmptyDDD = CradContent(shape: .diamond, color: .pink, shading: .empty)
        let cardContentEmptyRRR = CradContent(shape: .rectangle, color: .pink, shading: .empty)
        let cardContentEmptyOOO = CradContent(shape: .oval, color: .pink, shading: .empty)
        let cardContentSolidD = CradContent(shape: .diamond, color: .orange, shading: .solid)
        let cardContentSolidR = CradContent(shape: .rectangle, color: .orange, shading: .solid)
        let cardContentSolidO = CradContent(shape: .oval, color: .orange, shading: .solid)
        let cardContentSolidDD = CradContent(shape: .diamond, color: .teal, shading: .solid)
        let cardContentSolidRR = CradContent(shape: .rectangle, color: .teal, shading: .solid)
        let cardContentSolidOO = CradContent(shape: .oval, color: .teal, shading: .solid)
        let cardContentSolidDDD = CradContent(shape: .diamond, color: .pink, shading: .solid)
        let cardContentSolidRRR = CradContent(shape: .rectangle, color: .pink, shading: .solid)
        let cardContentSolidOOO = CradContent(shape: .oval, color: .pink, shading: .solid)
        let cardContentStripedD = CradContent(shape: .diamond, color: .orange, shading: .striped)
        let cardContentStripedR = CradContent(shape: .rectangle, color: .orange, shading: .striped)
        let cardContentStripedO = CradContent(shape: .oval, color: .orange, shading: .striped)
        
        let cardContentStripedDT = CradContent(shape: .diamond, color: .teal, shading: .striped)
        let cardContentStripedRT = CradContent(shape: .rectangle, color: .teal, shading: .striped)
        let cardContentStripedOT = CradContent(shape: .oval, color: .teal, shading: .striped)
        
        let cardContentStripedDP = CradContent(shape: .diamond, color: .pink, shading: .striped)
        let cardContentStripedRP = CradContent(shape: .rectangle, color: .pink, shading: .striped)
        let cardContentStripedOP = CradContent(shape: .oval, color: .pink, shading: .striped)
        
        let cardContentList = [cardContentEmptyD, cardContentEmptyR, cardContentEmptyO,
                               cardContentSolidD, cardContentSolidR, cardContentSolidO,
                                cardContentSolidDD, cardContentSolidRR, cardContentSolidOO,
                                cardContentSolidDDD, cardContentSolidRRR, cardContentSolidOOO,
                                cardContentEmptyDD, cardContentEmptyRR, cardContentEmptyOO,
                                cardContentEmptyDDD, cardContentEmptyRRR, cardContentEmptyOOO,
                                cardContentStripedD, cardContentStripedR, cardContentStripedO,
                                cardContentStripedDT, cardContentStripedRT, cardContentStripedOT,
                                cardContentStripedDP, cardContentStripedRP, cardContentStripedOP]
        
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

enum Shapes {
    case diamond
    case rectangle
    case oval
}

enum Shading {
    case solid
    case striped
    case empty
}
