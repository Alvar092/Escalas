//
//  BergItemPDF.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 23/1/26.
//

import Foundation

struct BergItemPDF {
    let number: Int
    let title: String
    let description: String
    let scoringOptions: [BergScoreOption]
    let score: Int
    let scoreDescription: String
    let maxScore: Int
    
    init(number: Int, definition: BergItemDefinition, item: BergItem, test: BergTest, scoreDescription: String) {
        self.number = number
        self.title = definition.title
        self.description = definition.description
        self.scoringOptions = definition.scoringOptions
        self.score = item.score ?? 0
        self.scoreDescription = scoreDescription
        self.maxScore = test.maxScore ?? 56
    }
  
}
