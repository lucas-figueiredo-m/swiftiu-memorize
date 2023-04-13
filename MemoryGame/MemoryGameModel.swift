//
//  MemoryGameModel.swift
//  MemoryGame
//
//  Created by Lucas Martins Figueiredo on 08/04/23.
//

import Foundation
import SwiftUI

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private let SCORE_MATCH = 2
    private let SCORE_MISMATCH = -1
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    private(set) var score: Int
    
    mutating func choose(_ card: Card) {
        let chosenIndex = cards.firstIndex(where: { $0.id == card.id })
        
        if let chosenIndex, !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].hasCardBeenSeen = true
                    cards[potentialMatchIndex].hasCardBeenSeen = true
                    score += SCORE_MATCH
                } else {
                    if cards[chosenIndex].hasCardBeenSeen || cards[potentialMatchIndex].hasCardBeenSeen {
                        score += SCORE_MISMATCH
                    }
                }
                cards[chosenIndex].hasCardBeenSeen = true
                cards[potentialMatchIndex].hasCardBeenSeen = true
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    if !cards[index].isMatched {
//                        if cards[index].isFaceUp && cards[index].hasCardBeenSeen {
//                            score += SCORE_MISMATCH
//                        }
//                        if cards[index].isFaceUp && !cards[index].hasCardBeenSeen {
//                            cards[index].hasCardBeenSeen = true
//                        }
                        cards[index].isFaceUp = false
                        
                    }
                    
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        score = 0
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasCardBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
    
    struct Theme {
        var name: String
        var emojiSet: [String]
        var numberOfPairs: Int
        var color: Color
    }
}
