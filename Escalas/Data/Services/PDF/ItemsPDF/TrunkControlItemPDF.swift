//
//  TrunkControlItemPDF.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 17/2/26.
//

import Foundation

struct TrunkControlItemPDF {
    let number: Int
    let title: String
    let description: String
    let scoringOptions: [TrunkControlScoreOption]
    let score: Int
    let scoreDescription: String
    let maxScore: Int
    
    init(number: Int, definition: TrunkControlItemDefinition, item: TrunkControlTestItem, scoreDescription: String) {
        self.number = number
        self.title = definition.title
        self.description = definition.description
        self.scoringOptions = definition.scoringOptions
        self.score = item.score ?? 0
        self.scoreDescription = scoreDescription
        self.maxScore = 33 // Puntuación máxima de cada ítem del Motricity Index
    }
}
