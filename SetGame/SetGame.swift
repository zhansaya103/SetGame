//
//  SetGame.swift
//  SetGame
//
//  Created by Zhansaya Ayazbayeva on 2021-01-27.
//

import Foundation

struct SetGame<CardContentType> {
    var cards: Array<Card>
    var selectedCards: [Card]
    var isThreeMatched = false
    var bonusTimeLimit: TimeInterval = 120
    var score: Int = 0
    var gameOver: Bool = false
    var bonus: Int = 0
    var isChecking: Bool = false
    
    mutating func check()  {
        isChecking = true
        isThreeMatched = false
        // 1
        let shapeOfFirstCard = selectedCards.first!.contentShape
        let colorOfFirstCard = selectedCards.first!.contentColor
        let shadingOfFirstCard = selectedCards.first!.contentShading
        var sameShapesCount = 0
        var sameColorCount = 0
        var sameShadingCount = 0
        var shapesAreSame = false
        var colorsAreSame = false
        var shadingsAreSame = false
        var midCard: Card?
        for card in selectedCards {
            
            if card.id != selectedCards.last!.id && card.id != selectedCards.first!.id {
                midCard = card
            }
            
            if shapeOfFirstCard == card.contentShape {
                sameShapesCount += 1
            } else if midCard != nil && midCard!.id != card.id && midCard!.contentShape == card.contentShape {
                sameShapesCount += 1
            }
            
            if colorOfFirstCard == card.contentColor {
                sameColorCount += 1
            } else if midCard != nil && midCard!.id != card.id && midCard!.contentColor == card.contentColor {
                sameColorCount += 1
            }
            
            if shadingOfFirstCard == card.contentShading {
                sameShadingCount += 1
            } else if midCard != nil && midCard!.id != card.id && midCard!.contentShading == card.contentShading {
                sameShadingCount += 1
            }
        }
        if sameShapesCount == 3 {
            shapesAreSame = true
        }
        if sameColorCount == 3 {
            colorsAreSame = true
        }
        if sameShadingCount == 3 {
            shadingsAreSame = true
        }
        
        // case 1
        if shapesAreSame {
            if sameColorCount == 1 && sameShadingCount == 1 {
                isThreeMatched = true
            }
        }
        // case 2
        else if shadingsAreSame {
            if sameColorCount == 1 && sameShapesCount == 1 {
                isThreeMatched = true
            }
        }
        // case 3
        else if colorsAreSame {
            if sameShadingCount == 1 && sameShapesCount == 1 {
                isThreeMatched = true
            }
        }
        // case 4
        else if sameShadingCount == 1 && sameColorCount == 1 && sameShapesCount == 1 {
            isThreeMatched = true
        } else {
            isThreeMatched = false
        }
        
        if isThreeMatched {
            for card in selectedCards {
                guard let index = cards.firsrIndexOf(matching: card) else { return }
                cards[index].isMatched = true
                cards[index].isChecked = true
            }
        } else {
            for card in selectedCards {
                guard let index = cards.firsrIndexOf(matching: card) else { return }
                cards[index].isMatched = false
                cards[index].isChecked = true
            }
        }
        
        
    }
    
    
    mutating func unSelect() {
        guard selectedCards.count != 0 else {
            return
        }
        if self.isThreeMatched {
            score = score + 5
            for i in 0..<3 {
                let index = cards.firsrIndexOf(matching: selectedCards[i])!
                cards.remove(at: index)
            }
            
        } else {
            score = score < 5 ? 0 : score - 5
            for i in 0..<3 {
                let index = cards.firsrIndexOf(matching: selectedCards[i])!
                cards[index].isMatched = nil
                cards[index].isChecked = false
                cards[index].isSelected = false
                
            }
        }
        selectedCards.removeAll()
        if cards.count == 0 {
            bonus = Int(bonusTimeLimit * 3)
            gameOver = true
        }
        isChecking = false
    }
    
    mutating func getRemainingTime(_ remainingSeconds: TimeInterval) {
        print(remainingSeconds)
        bonusTimeLimit = remainingSeconds
        if bonusTimeLimit == 0 {
            gameOver = true
        }
    }
    
    mutating func choose(card: Card) {
        let index = cards.firsrIndexOf(matching: card)!
        cards[index].isSelected = !cards[index].isSelected
        if cards[index].isSelected {
            selectedCards.append(cards[index])
            if selectedCards.count > 3 {
                
                for _ in 0..<3 {
                    let index = cards.firsrIndexOf(matching: selectedCards.removeFirst())!
                    cards[index].isSelected = false
                }
            }
        } else {
            if selectedCards.contains(where: { card -> Bool in
                card.id == cards[index].id
                
            }) {
                let i = selectedCards.firstIndex { (card) -> Bool in
                    card.id == cards[index].id
                }
                selectedCards.remove(at: i!)
            }
        }
    }
    
    init(numberOfCards: Int, cardContentFactory: (Int) -> CardContentType) {
        
        self.cards = Array<Card>()
        self.selectedCards = [Card]()
        
        for i in 0..<numberOfCards {
            let content = cardContentFactory(i) as! CradContent
            cards.append(Card(id: i,
                              isMatched: false,
                              isSelected: false,
                              contentShape: content.shape,
                              contentColor: content.color,
                              contentShading: content.shading))
        }
        self.cards.shuffle()
        
    }
    
    
    
    
    struct Card: Identifiable {
        var id: Int
        var isMatched: Bool?
        var isSelected: Bool = false
        var contentShape: Shapes
        var contentColor: ContentColor
        var contentShading: Shading
        var isChecked: Bool = false
    }
}
