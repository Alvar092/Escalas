//
//  BergTest.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//
import Foundation

struct BergTest: ClinicalTestProtocol {
    let id: UUID
    var date: Date
    var patientID: UUID
    var items: [BergItem]
    
    var totalScore: Int {
        items.reduce(0) {$0 + $1.score}
    }
}

struct BergItem: Codable {
    let id: UUID
    let itemType: BergItemType
    var score: Int = 0
    var timeRecorded: TimeInterval?
    
    mutating func setScore(_ value: Int) {
        score = max(0, min(4, value))
    }
}

enum BergItemType: Int, CaseIterable, Codable {
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



