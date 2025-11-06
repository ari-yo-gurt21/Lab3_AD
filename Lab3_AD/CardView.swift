//
// Lab# 3
// Group #
// Ari Lee and David Deng
// Date: 2025-11-07
//
// CardView.swift
// Presentation of a single memory card (stateless)
//

import SwiftUI

struct CardView: View {
    let card: CardModel
    let size: CGFloat
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            // Card container
            RoundedRectangle(cornerRadius: 12)
                .fill(card.isMatched ? Color.green.opacity(0.18) : Color.white)
                .shadow(radius: 3)
            
            if card.isFaceUp || card.isMatched {
                // the front
                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(size * 0.12)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    // when matched, a small animation will be applied
                    
                    .scaleEffect(card.isMatched ? 1.05 : 1.0)
                    .animation(card.isMatched ? .easeInOut(duration: 0.3).repeatCount(1, autoreverses: true) : .default, value: card.isMatched)
            } else {
                // the back
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.orange.opacity(0.85))
                    .overlay(
                        Text("🎃")
                            .font(.system(size: size * 0.28))
                    )
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: size, maxHeight: size)
        .onTapGesture {
            onTap()
        }
        // Flip rotate when face down
        .rotation3DEffect(
            .degrees(card.isFaceUp || card.isMatched ? 0 : 180),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .animation(.easeInOut(duration: 0.33), value: card.isFaceUp)
        .opacity(card.isMatched ? 0.85 : 1.0)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: CardModel(imageName: "halloween1", isFaceUp: false), size: 100) { }
                .previewLayout(.sizeThatFits)
                .padding()
            CardView(card: CardModel(imageName: "halloween2", isFaceUp: true), size: 100) { }
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
