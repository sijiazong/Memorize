//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sijia Zong on 10/25/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let numOfPairs = [2, 5]
        let randomPair = numOfPairs.randomElement()!
        let emojis: Array<String> = ["🎃", "👻", "🕷", "🕸", "🍬"]
        return MemoryGame<String>(numOfPairsOfCards: randomPair) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to model
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }

    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
