//
//  BergItemCatalog.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/1/26.
//

import Foundation

enum BergItemCatalog {

    static let definitions: [BergItemType: BergItemDefinition] = [

        // MARK: - Item 1
        .sittingToStanding: BergItemDefinition(
            type: .sittingToStanding,
            title: String(localized: "berg.sittingToStanding.title", table: "Berg"),
            description: String(localized: "berg.sittingToStanding.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.sittingToStanding.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.sittingToStanding.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.sittingToStanding.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.sittingToStanding.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.sittingToStanding.score.0", table: "Berg"))
            ],
            needsTimer: false
        ),

        // MARK: - Item 2
        .standingUnsupported: BergItemDefinition(
            type: .standingUnsupported,
            title: String(localized: "berg.standingUnsupported.title", table: "Berg"),
            description: String(localized: "berg.standingUnsupported.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.standingUnsupported.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.standingUnsupported.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.standingUnsupported.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.standingUnsupported.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.standingUnsupported.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 3
        .sittingWithBackUnsupported: BergItemDefinition(
            type: .sittingWithBackUnsupported,
            title: String(localized: "berg.sittingWithBackUnsupported.title", table: "Berg"),
            description: String(localized: "berg.sittingWithBackUnsupported.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.sittingWithBackUnsupported.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.sittingWithBackUnsupported.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.sittingWithBackUnsupported.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.sittingWithBackUnsupported.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.sittingWithBackUnsupported.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 4
        .standingToSitting: BergItemDefinition(
            type: .standingToSitting,
            title: String(localized: "berg.standingToSitting.title", table: "Berg"),
            description: String(localized: "berg.standingToSitting.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.standingToSitting.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.standingToSitting.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.standingToSitting.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.standingToSitting.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.standingToSitting.score.0", table: "Berg"))
            ],
            needsTimer: false
        ),

        // MARK: - Item 5
        .transfers: BergItemDefinition(
            type: .transfers,
            title: String(localized: "berg.transfers.title", table: "Berg"),
            description: String(localized: "berg.transfers.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.transfers.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.transfers.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.transfers.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.transfers.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.transfers.score.0", table: "Berg"))
            ],
            needsTimer: false
        ),

        // MARK: - Item 6
        .standingUnsupportedWithEyesClosed: BergItemDefinition(
            type: .standingUnsupportedWithEyesClosed,
            title: String(localized: "berg.standingUnsupportedWithEyesClosed.title", table: "Berg"),
            description: String(localized: "berg.standingUnsupportedWithEyesClosed.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.standingUnsupportedWithEyesClosed.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.standingUnsupportedWithEyesClosed.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.standingUnsupportedWithEyesClosed.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.standingUnsupportedWithEyesClosed.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.standingUnsupportedWithEyesClosed.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 7
        .standingUnsupportedWithFeetTogether: BergItemDefinition(
            type: .standingUnsupportedWithFeetTogether,
            title: String(localized: "berg.standingUnsupportedWithFeetTogether.title", table: "Berg"),
            description: String(localized: "berg.standingUnsupportedWithFeetTogether.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.standingUnsupportedWithFeetTogether.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.standingUnsupportedWithFeetTogether.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.standingUnsupportedWithFeetTogether.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.standingUnsupportedWithFeetTogether.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.standingUnsupportedWithFeetTogether.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 8
        .reachingForwardWithOutstrechedArmWhileStanding: BergItemDefinition(
            type: .reachingForwardWithOutstrechedArmWhileStanding,
            title: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.title", table: "Berg"),
            description: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.reachingForwardWithOutstretchedArmWhileStanding.score.0", table: "Berg"))
            ],
            needsTimer: false
        ),

        // MARK: - Item 9
        .PickUpObjectFromTheFloorFromAStandingPosition: BergItemDefinition(
            type: .PickUpObjectFromTheFloorFromAStandingPosition,
            title: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.title", table: "Berg"),
            description: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.pickUpObjectFromTheFloorFromAStandingPosition.score.0", table: "Berg"))
            ],
            needsTimer: false
        ),

        // MARK: - Item 10
        .turningToLookBehindOverLeftAndRightShoulders: BergItemDefinition(
            type: .turningToLookBehindOverLeftAndRightShoulders,
            title: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.title", table: "Berg"),
            description: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.turningToLookBehindOverLeftAndRightShoulders.score.0", table: "Berg"))
            ],
            needsTimer: false
        ),

        // MARK: - Item 11
        .turn360Degrees: BergItemDefinition(
            type: .turn360Degrees,
            title: String(localized: "berg.turn360Degrees.title", table: "Berg"),
            description: String(localized: "berg.turn360Degrees.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.turn360Degrees.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.turn360Degrees.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.turn360Degrees.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.turn360Degrees.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.turn360Degrees.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 12
        .PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported: BergItemDefinition(
            type: .PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported,
            title: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.title", table: "Berg"),
            description: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.placingAlternatesFootOnStepOrStoolWhileStandingUnsupported.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 13
        .StandingUnsupportedOneFootInFront: BergItemDefinition(
            type: .StandingUnsupportedOneFootInFront,
            title: String(localized: "berg.standingUnsupportedOneFootInFront.title", table: "Berg"),
            description: String(localized: "berg.standingUnsupportedOneFootInFront.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.standingUnsupportedOneFootInFront.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.standingUnsupportedOneFootInFront.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.standingUnsupportedOneFootInFront.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.standingUnsupportedOneFootInFront.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.standingUnsupportedOneFootInFront.score.0", table: "Berg"))
            ],
            needsTimer: true
        ),

        // MARK: - Item 14
        .StandingOnOneLeg: BergItemDefinition(
            type: .StandingOnOneLeg,
            title: String(localized: "berg.standingOnOneLeg.title", table: "Berg"),
            description: String(localized: "berg.standingOnOneLeg.description", table: "Berg"),
            scoringOptions: [
                .init(score: 4, description: String(localized: "berg.standingOnOneLeg.score.4", table: "Berg")),
                .init(score: 3, description: String(localized: "berg.standingOnOneLeg.score.3", table: "Berg")),
                .init(score: 2, description: String(localized: "berg.standingOnOneLeg.score.2", table: "Berg")),
                .init(score: 1, description: String(localized: "berg.standingOnOneLeg.score.1", table: "Berg")),
                .init(score: 0, description: String(localized: "berg.standingOnOneLeg.score.0", table: "Berg"))
            ],
            needsTimer: true
        )
    ]

    static func allDefinitions() -> [BergItemDefinition] {
        Array(definitions.values)
    }
}
