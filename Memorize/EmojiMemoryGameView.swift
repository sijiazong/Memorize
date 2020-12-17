//
//  ContentView.swift
//  Memorize
//
//  Created by Sijia Zong on 10/23/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            // new game button
            Button(action: {
                self.viewModel.createNewGame()
            }) {
                Text("New Game")
            }
            .padding()
            // display game theme
            Text("Game Theme: " + EmojiMemoryGame.theme!.name.rawValue.uppercased())
            // display game score
            Text("Score: " + String(self.viewModel.model.score))
            // grid of cards
            Grid(items: viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture{
                        self.viewModel.choose(card: card)
                }
            }
            .foregroundColor(EmojiMemoryGame.theme!.color)
            .padding()
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .stroke(lineWidth: self.edgeLineWidth)
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(100-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: self.fontScaleFactor * min(size.width, size.width)))
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
