//
//  ContentView.swift
//  Memorize
//
//  Created by Sijia Zong on 10/23/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    var fontSize: Font {
        if viewModel.cards.count < 5 {
            return Font.largeTitle
        } else {
            return Font.body
        }
    }
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards){ card in
                CardView(card: card).onTapGesture{
                    self.viewModel.choose(card: card)
                }
            }
        }
            .foregroundColor(Color.orange)
            .padding()
            .font(fontSize)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .aspectRatio(2/3, contentMode: .fit)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .aspectRatio(2/3, contentMode: .fit)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: 10).fill()
                }
            }
        }
}



























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
