//
//  TrunkControlIndexCatalog.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 17/2/26.
//

import Foundation

enum TrunkControlTestCatalog {

    static let definitions: [TrunkControlItemType: TrunkControlItemDefinition] = [

        .rollingToWeakSide: TrunkControlItemDefinition(
            type: .rollingToWeakSide,
            title: "Giro hacia el lado afecto",
            description: "Capacidad para girar desde decúbito supino hacia el lado afecto.",
            scoringOptions: standardScoring
        ),

        .rollingToStrongSide: TrunkControlItemDefinition(
            type: .rollingToStrongSide,
            title: "Giro hacia el lado sano",
            description: "Capacidad para girar desde decúbito supino hacia el lado sano.",
            scoringOptions: standardScoring
        ),

        .balancedSitting: TrunkControlItemDefinition(
            type: .balancedSitting,
            title: "Equilibrio en sedestación",
            description: "Capacidad para mantenerse sentado sin apoyo durante al menos 30 segundos.",
            scoringOptions: standardScoring
        ),
        
            .sittingUpFromLyingDown: TrunkControlItemDefinition(
                type: .sittingUpFromLyingDown,
                title: "Incorporación desde supino",
                description: "Capacidad para incorporarse desde decúbito supino hasta sedestación.",
                scoringOptions: standardScoring
            )
    ]

    // MARK: - Standard Scoring (TCT Official Scale)

    private static let standardScoring: [TrunkControlScoreOption] = [
        .init(score: 0, description: "0. Incapaz de realizar la tarea sin ayuda."),
        .init(score: 12, description: "12. Realiza la tarea con ayuda."),
        .init(score: 25, description: "25. Realiza la tarea de forma independiente.")
    ]
}
