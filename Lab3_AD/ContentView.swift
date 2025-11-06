// David Deng and Ari Lee
// Lab# 3
// Group #
// Your Full Names
// Made on 11-07-25
// ContentView.swift
// Memory Game (MVVM)
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MemoryGameViewModel()
    
    // 3-column grid
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            // Background image
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.38)
            
            VStack(spacing: 12) {
                // Header
                VStack(spacing: 6) {
                    Text("Halloween")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundColor(.orange)
                        .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 2)
                    Text("Memory Card Game")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 12)
                
                // Card grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(vm.cards) { card in
                            GeometryReader { geo in
                                CardView(card: card, size: min(geo.size.width, geo.size.height)) {
                                    vm.flipCard(card)
                                }
                               
                                .scaleEffect(card.isMatched ? 1.02 : 1.0)
                                .opacity(card.isMatched ? 0.85 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: card.isMatched)
                            }
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                }
                
                Spacer()
                
                // Play Again button appears only after completion
                if vm.gameCompleted {
                    Button(action: {
                        withAnimation(.spring()) {
                            vm.setupGame()
                        }
                    }) {
                        Text("Play Again")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(Color.orange)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                    .padding(.bottom, 30)
                    .padding(.top, 6)
                }
            }
        }
        .onAppear {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
