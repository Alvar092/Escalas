//
//  TrunkControlItemDefinition.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 17/2/26.
//

import Foundation

struct TrunkControlItemDefinition {
    let type: TrunkControlItemType
    let title: String
    let description: String
    let scoringOptions: [TrunkControlScoreOption]
    
    func scoreDescription(for score: Int) -> String {
        scoringOptions.first(where: {$0.score == score})?.description ?? ""
    }
}
