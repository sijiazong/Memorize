//
//  Cardify.swift
//  Memorize
//
//  Created by Sijia Zong on 12/17/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .stroke(lineWidth: self.edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill()
            }
        }
    }
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
