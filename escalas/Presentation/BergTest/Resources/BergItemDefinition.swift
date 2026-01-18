//
//  BergItemDefinition.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/1/26.
//

import Foundation

struct BergItemDefinition {
    let type: BergItemType
    let title: String
    let description: String
    let scoringOptions: [BergScoreOption]
    let needsTimer: Bool
}
