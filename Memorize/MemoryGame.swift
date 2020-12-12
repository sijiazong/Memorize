//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sijia Zong on 10/25/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable & Hashable {
    var cards: Array<Card>
    var score: Int = 0
    var seenCardContents = Set<CardContent>()
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp }
            return faceUpCardIndices.only
        }
        set {
            // set other cards to face down when set the only card face up
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    //  struct are value types, need mutating prefix for functions that will change the struct
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card),  !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            let cardContent = cards[chosenIndex].content
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if seenCardContents.contains(cardContent){
                    score -= 1
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            seenCardContents.insert(cardContent)
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
