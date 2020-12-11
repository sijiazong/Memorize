//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sijia Zong on 10/25/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import SwiftUI

// ObservableObject must be a class
class EmojiMemoryGame: ObservableObject {
//  mark @published to call objectWillChange.send() when view need to change when it changes
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static var theme: Theme?

    static func createMemoryGame() -> MemoryGame<String> {
        let themeName: EmojiTheme = EmojiTheme.allCases.randomElement()!
        let theme = Theme(name: themeName, numOfPairs: nil)
        self.theme = theme
        return MemoryGame<String>(numOfPairsOfCards: theme.numOfPairs) { pairIndex in
            return theme.emojis[pairIndex]
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

enum EmojiTheme: CaseIterable {
    case halloween, animals, sports, faces, flags
}

struct Theme {
    var name: EmojiTheme
    var numOfPairs: Int
    var emojis: [String]
    var color: Color

    init(name: EmojiTheme, numOfPairs: Int?) {
        self.name = name
        switch name {
        case .halloween:
            emojis = ["🎃", "👻", "🕷", "🕸", "🍬", "☠️"]
            color = Color.orange
        case .animals:
            emojis = ["🐶", "🐱", "🐰", "🦊", "🐻", "🐼", "🐷", "🐮"]
            color = Color.blue
        case .sports:
            emojis = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱"]
            color = Color.gray
        case .faces:
            emojis = ["😀","😆","😂","😍","😘","😭","🥺","😱","😤","😴","😷","😵","😈"]
            color = Color.yellow
        case .flags:
            emojis = ["🇦🇺","🇨🇦","🇧🇷","🇩🇪","🇯🇵","🇰🇷","🇬🇧","🇺🇸","🇨🇳","🇫🇷","🇮🇳"]
            color = Color.red
        }
//        set number of cards if provided, else random
        if let num = numOfPairs {
            self.numOfPairs = num
        } else {
            self.numOfPairs = Int.random(in: 2...self.emojis.count)
        }
    }
}


struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
