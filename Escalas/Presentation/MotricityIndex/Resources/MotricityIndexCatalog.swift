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
            title: "Pinza fina",
            description: "Capacidad para realizar pinza entre pulgar e índice.",
            scoringOptions: standardScoring
        ),

        .elbowFlexion: MotricityItemDefinition(
            type: .elbowFlexion,
            title: "Flexión de codo",
            description: "Flexión activa del codo contra gravedad o resistencia.",
            scoringOptions: standardScoring
        ),

        .shoulderAbduction: MotricityItemDefinition(
            type: .shoulderAbduction,
            title: "Abducción de hombro",
            description: "Abducción activa del hombo contra gravedad o resistencia.",
            scoringOptions: standardScoring
        ),

        // MARK: - Lower Limb

        .ankleDorsiflexion: MotricityItemDefinition(
            type: .ankleDorsiflexion,
            title: "Dorsiflexión de tobillo",
            description: "Elevación activa del pie contra gravedad.",
            scoringOptions: standardScoring
        ),

        .kneeExtension: MotricityItemDefinition(
            type: .kneeExtension,
            title: "Extensión de rodilla",
            description: "Extensión activa de la rodilla contra gravedad o resistencia.",
            scoringOptions: standardScoring
        ),

        .hipFlexion: MotricityItemDefinition(
            type: .hipFlexion,
            title: "Flexión de cadera",
            description: "Flexión activa de cadera contra gravedad o resistencia.",
            scoringOptions: standardScoring
        )
    ]

    // MARK: - Standard Scoring (Motricity Index Official Scale)

    private static let standardScoring: [MotricityScoreOption] = [
        .init(score: 0, description: "0. No contracción visible."),
        .init(score: 9, description: "9. Contracción palpable sin movimiento."),
        .init(score: 14, description: "14. Movimiento sin vencer gravedad."),
        .init(score: 19, description: "19. Movimiento venciendo gravedad."),
        .init(score: 25, description: "25. Movimiento contra resistencia leve."),
        .init(score: 33, description: "33. Fuerza normal.")
    ]
}
