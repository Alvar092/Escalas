//
//  BergTest.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//
import Foundation

struct BergTest {
    let id: UUID
    var date: Date
    var patient: Patient
    var items: [BergItem]
    
    var totalScore: Int {
        items.reduce(0) {$0 + $1.score}
    }
}

struct BergItem {
    let id: UUID
    let itemType: BergItemType
    var score: Int
    var timeRecorded: TimeInterval?
}

enum BergItemType: Int, CaseIterable {
    case sittingToStanding = 0
    case standingUnsupported = 1
    case sittingWithBackUnsupported = 2
    case standingToSitting = 3
    case transfers = 4
    case standingUnsupportedWithEyesClosed = 5
    case standingUnsupportedWithFeetTogether = 6
    case reachingForwardWithOutstrechedArmWhileStanding = 7
    case PickUpObjectFromTheFloorFromAStandingPosition = 8
    case turningToLookBehindOverLeftAndRightShoulders = 9
    case turn360Degrees = 10
    case PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported = 11
    case StandingUnsupportedOneFootInFront = 12
    case StandingOnOneLeg = 13
    
    var needsTimer: Bool {
        switch self {
        case
                .standingUnsupported,
                .sittingWithBackUnsupported,
                .standingUnsupportedWithEyesClosed,
                .standingUnsupportedWithFeetTogether,
                .turn360Degrees,
                .PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported,
                .StandingUnsupportedOneFootInFront,
                .StandingOnOneLeg:
            return true
        default:
            return false
        }
    }
}
