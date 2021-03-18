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
    var bonusTimeLimit: TimeInterval = 55
    var score: Int = 0
    var gameOver: Bool = false
    var bonus: Int = 0
    var isChecking: Bool = false
    
    mutating func check()  {
        isChecking = true
        if  (   selectedCards[0].contentShape != selectedCards[1].contentShape &&
                selectedCards[0].contentShading == selectedCards[1].contentShading &&
                selectedCards[0].contentColor != selectedCards[1].contentColor &&
                selectedCards[0].contentShape != selectedCards[2].contentShape &&
                selectedCards[0].contentShading == selectedCards[2].contentShading &&
                selectedCards[0].contentColor != selectedCards[2].contentColor &&
                selectedCards[1].contentShape != selectedCards[2].contentShape) ||
                
                (selectedCards[0].contentShape != selectedCards[1].contentShape &&
                selectedCards[0].contentShading != selectedCards[1].contentShading &&
                selectedCards[0].contentColor == selectedCards[1].contentColor &&
                selectedCards[0].contentShape != selectedCards[2].contentShape &&
                selectedCards[0].contentShading != selectedCards[2].contentShading &&
                selectedCards[0].contentColor == selectedCards[2].contentColor &&
                selectedCards[1].contentShape != selectedCards[2].contentShape) ||
                
                (selectedCards[0].contentShape == selectedCards[1].contentShape &&
                    selectedCards[0].contentShading == selectedCards[1].contentShading &&
                    selectedCards[0].contentColor != selectedCards[1].contentColor &&
                    selectedCards[0].contentShape == selectedCards[2].contentShape &&
                    selectedCards[0].contentShading == selectedCards[2].contentShading &&
                    selectedCards[0].contentColor != selectedCards[2].contentColor &&
                    selectedCards[1].contentShape == selectedCards[2].contentShape) ||
                
                (selectedCards[0].contentShape == selectedCards[1].contentShape &&
                    selectedCards[0].contentShading == selectedCards[1].contentShading &&
                    selectedCards[0].contentColor != selectedCards[1].contentColor &&
                    selectedCards[0].contentShape == selectedCards[2].contentShape &&
                    selectedCards[0].contentShading == selectedCards[2].contentShading &&
                    selectedCards[0].contentColor != selectedCards[2].contentColor &&
                    selectedCards[1].contentShape == selectedCards[2].contentShape) ||
                
                (selectedCards[0].contentShape != selectedCards[1].contentShape &&
                    selectedCards[0].contentShading == selectedCards[1].contentShading &&
                    selectedCards[0].contentColor == selectedCards[1].contentColor &&
                    selectedCards[0].contentShape != selectedCards[2].contentShape &&
                    selectedCards[0].contentShading == selectedCards[2].contentShading &&
                    selectedCards[0].contentColor == selectedCards[2].contentColor &&
                    selectedCards[1].contentShape != selectedCards[2].contentShape) {
            
            
            for i in 0..<3 {
                let index = cards.firsrIndexOf(matching: selectedCards[i])!
                cards[index].isMatched = true
                cards[index].isChecked = true
            }
            isThreeMatched = true
        } else {
            
            for i in 0..<3 {
                let index = cards.firsrIndexOf(matching: selectedCards[i])!
                cards[index].isMatched = false
                cards[index].isChecked = true
            }
            isThreeMatched = false
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
        print(cards)
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
