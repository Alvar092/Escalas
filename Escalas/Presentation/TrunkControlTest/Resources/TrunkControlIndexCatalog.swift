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
            title: String(localized: "trunkControl.rollingToWeakSide.title", table: "TrunkControl"),
            description: String(localized: "trunkControl.rollingToWeakSide.description", table: "TrunkControl"),
            scoringOptions: standardScoring
        ),

        .rollingToStrongSide: TrunkControlItemDefinition(
            type: .rollingToStrongSide,
            title: String(localized: "trunkControl.rollingToStrongSide.title", table: "TrunkControl"),
            description: String(localized: "trunkControl.rollingToStrongSide.description", table: "TrunkControl"),
            scoringOptions: standardScoring
        ),

        .balancedSitting: TrunkControlItemDefinition(
            type: .balancedSitting,
            title: String(localized: "trunkControl.balancedSitting.title", table: "TrunkControl"),
            description: String(localized: "trunkControl.balancedSitting.description", table: "TrunkControl"),
            scoringOptions: standardScoring
        ),

        .sittingUpFromLyingDown: TrunkControlItemDefinition(
            type: .sittingUpFromLyingDown,
            title: String(localized: "trunkControl.sittingUpFromLyingDown.title", table: "TrunkControl"),
            description: String(localized: "trunkControl.sittingUpFromLyingDown.description", table: "TrunkControl"),
            scoringOptions: standardScoring
        )
    ]

    // MARK: - Standard Scoring (TCT Official Scale)

    private static let standardScoring: [TrunkControlScoreOption] = [
        .init(score: 0,  description: String(localized: "trunkControl.standard.score.0",  table: "TrunkControl")),
        .init(score: 12, description: String(localized: "trunkControl.standard.score.12", table: "TrunkControl")),
        .init(score: 25, description: String(localized: "trunkControl.standard.score.25", table: "TrunkControl"))
    ]
}
