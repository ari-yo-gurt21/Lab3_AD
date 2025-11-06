// Lab# 3
// Group #
// Ari Lee and David Deng
// Date: 11-8-25
// CardModel.swift
// 

import Foundation

struct CardModel: Identifiable, Equatable {
    let id: UUID
    let imageName: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    
    init(id: UUID = UUID(), imageName: String, isFaceUp: Bool = false, isMatched: Bool = false) {
        self.id = id
        self.imageName = imageName
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
    }
}
