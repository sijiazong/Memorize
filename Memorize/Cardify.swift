//
//  Cardify.swift
//  Memorize
//
//  Created by Sijia Zong on 12/17/20.
//  Copyright © 2020 Sijia Zong. All rights reserved.
//

import SwiftUI

// AnimatableModifier = ViewModifier + Animatable
struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    var isFaceUp: Bool {
        return rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            // use opacity instead of if else to make view always on screen but not visible
            // front
            Group {
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .stroke(lineWidth: self.edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            // back
            RoundedRectangle(cornerRadius: self.cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
