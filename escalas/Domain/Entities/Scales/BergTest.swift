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
        items.compactMap { $0.score }.reduce(0,+)
    }
}

struct BergItem: Codable {
    let id: UUID
    let itemType: BergItemType
    var score: Int? = nil
    var timeRecorded: TimeInterval?
    
    mutating func setScore(_ value: Int?) {
        score = value.map {max(0,min(4,$0)) }
    }
    
    mutating func timeScoring() {
        guard let timeRecorded = timeRecorded else { return}
        switch itemType {
        case .sittingToStanding,
                .standingToSitting,
                .transfers,
                .reachingForwardWithOutstrechedArmWhileStanding,
                .PickUpObjectFromTheFloorFromAStandingPosition,
                .turningToLookBehindOverLeftAndRightShoulders:
            return
            
        case .standingUnsupported:
            if timeRecorded >= 120.00 {
                setScore(4)
            } else if timeRecorded >= 30.0 {
                setScore(2)
            } else {
                setScore(0)
            }
            
            
        case .sittingWithBackUnsupported:
            if timeRecorded >= 120.00 {
                setScore(4)
            } else if timeRecorded >= 30.00 {
                setScore(2)
            } else if timeRecorded >= 10.0 {
                setScore(1)
            } else {
                setScore(0)
            }
            
        case .standingUnsupportedWithEyesClosed:
            if timeRecorded >= 10.00 {
                setScore(4)
            } else if timeRecorded >= 3.00 {
                setScore(2)
            } else {
                setScore(0)
            }
            
        case .standingUnsupportedWithFeetTogether:
            if timeRecorded >= 60.00 {
                setScore(4)
            }
            else if timeRecorded >= 30.00 {
                setScore(2)
            }
            else if timeRecorded > 15.00 {
                setScore(1)
            }
            else {
                setScore(0)
            }
            
        case .turn360Degrees:
            if timeRecorded <= 4.00 {
                setScore(4)
            }
            else {
                setScore(2)
            }
        case .PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported:
            if timeRecorded <= 20.00 {
                setScore(4)
            } else {
                setScore(3)
            }
            
        case .StandingUnsupportedOneFootInFront:
            if timeRecorded >= 30.00 {
                setScore(4)
            }
            else if timeRecorded >= 15.00 {
                setScore(1)
            }
            else {
                setScore(0)
            }
            
        case .StandingOnOneLeg:
            if timeRecorded >= 10.00 {
                setScore(4)
            } else if timeRecorded >= 5.00 {
                setScore(3)
            } else if timeRecorded >= 3.00 {
                setScore(2)
            } else {
                setScore(0)
            }
        }
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
}



