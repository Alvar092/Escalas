//
//  MotricityItemDefinition.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 11/2/26.
//

import Foundation

struct MotricityItemDefinition {
    let type: MotricityIndexItemType
    let title: String
    let description: String
    let scoringOptions: [MotricityScoreOption]
    
    func scoreDescription(for score: Int) -> String {
        scoringOptions.first(where: {$0.score == score})?.description ?? ""
    }
}

