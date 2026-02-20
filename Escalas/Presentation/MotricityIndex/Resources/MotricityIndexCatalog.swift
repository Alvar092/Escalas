//
//  MotricityIndexCatalog.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 11/2/26.
//

import Foundation

enum MotricityIndexCatalog {

    static let definitions: [MotricityIndexItemType: MotricityItemDefinition] = [

        // MARK: - Upper Limb

        .pinchGrip: MotricityItemDefinition(
            type: .pinchGrip,
            title: String(localized: "motricity.pinchGrip.title", table: "Motricity"),
            description: String(localized: "motricity.pinchGrip.description", table: "Motricity"),
            scoringOptions: pinchGripScoring
        ),

        .elbowFlexion: MotricityItemDefinition(
            type: .elbowFlexion,
            title: String(localized: "motricity.elbowFlexion.title", table: "Motricity"),
            description: String(localized: "motricity.elbowFlexion.description", table: "Motricity"),
            scoringOptions: standardScoring
        ),

        .shoulderAbduction: MotricityItemDefinition(
            type: .shoulderAbduction,
            title: String(localized: "motricity.shoulderAbduction.title", table: "Motricity"),
            description: String(localized: "motricity.shoulderAbduction.description", table: "Motricity"),
            scoringOptions: standardScoring
        ),

        // MARK: - Lower Limb

        .ankleDorsiflexion: MotricityItemDefinition(
            type: .ankleDorsiflexion,
            title: String(localized: "motricity.ankleDorsiflexion.title", table: "Motricity"),
            description: String(localized: "motricity.ankleDorsiflexion.description", table: "Motricity"),
            scoringOptions: standardScoring
        ),

        .kneeExtension: MotricityItemDefinition(
            type: .kneeExtension,
            title: String(localized: "motricity.kneeExtension.title", table: "Motricity"),
            description: String(localized: "motricity.kneeExtension.description", table: "Motricity"),
            scoringOptions: standardScoring
        ),

        .hipFlexion: MotricityItemDefinition(
            type: .hipFlexion,
            title: String(localized: "motricity.hipFlexion.title", table: "Motricity"),
            description: String(localized: "motricity.hipFlexion.description", table: "Motricity"),
            scoringOptions: standardScoring
        )
    ]

    // MARK: - Standard Scoring (Motricity Index Official Scale)

    private static let standardScoring: [MotricityScoreOption] = [
        .init(score: 0,  description: String(localized: "motricity.standard.score.0",  table: "Motricity")),
        .init(score: 9,  description: String(localized: "motricity.standard.score.9",  table: "Motricity")),
        .init(score: 14, description: String(localized: "motricity.standard.score.14", table: "Motricity")),
        .init(score: 19, description: String(localized: "motricity.standard.score.19", table: "Motricity")),
        .init(score: 25, description: String(localized: "motricity.standard.score.25", table: "Motricity")),
        .init(score: 33, description: String(localized: "motricity.standard.score.33", table: "Motricity"))
    ]

    private static let pinchGripScoring: [MotricityScoreOption] = [
        .init(score: 0,  description: String(localized: "motricity.pinchGrip.score.0",  table: "Motricity")),
        .init(score: 11, description: String(localized: "motricity.pinchGrip.score.11", table: "Motricity")),
        .init(score: 19, description: String(localized: "motricity.pinchGrip.score.19", table: "Motricity")),
        .init(score: 22, description: String(localized: "motricity.pinchGrip.score.22", table: "Motricity")),
        .init(score: 26, description: String(localized: "motricity.pinchGrip.score.26", table: "Motricity")),
        .init(score: 33, description: String(localized: "motricity.pinchGrip.score.33", table: "Motricity"))
    ]
}
