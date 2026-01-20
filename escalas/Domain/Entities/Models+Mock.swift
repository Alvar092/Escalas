//
//  Patient+Mock.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import Foundation

extension Patient{
    
    static let patient1 = Patient(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001") ?? UUID(),
        name: "Juan Pérez",
        dateOfBirth: Calendar.current.date(byAdding: .year, value: -68, to: .now)!
    )
    
    static let patient2 = Patient(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002") ?? UUID(),
        name: "Ana García",
        dateOfBirth: Calendar.current.date(byAdding: .year, value: -55, to: .now)!
    )
    
    static let patient3 = Patient(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000003") ?? UUID(),
        name: "Carlos Martínez",
        dateOfBirth: Calendar.current.date(byAdding: .year, value: -42, to: .now)!
    )
}

extension BergTest {
    
    static let patient1 = BergTest(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -10, to: .now)!,
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000001") ?? UUID(),
        items: BergItem.mockItems
    )
    
    static let patient2 = BergTest(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -7, to: .now)!,
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000002") ?? UUID(),
        items: [
            BergItem(id: UUID(), itemType: .standingToSitting, score: 3),
            BergItem(id: UUID(), itemType: .transfers, score: 4),
            BergItem(id: UUID(), itemType: .standingUnsupportedWithEyesClosed, score: 2)
        ]
    )
    
    static let patient3 = BergTest(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000003") ?? UUID(),
        items: [
            BergItem(id: UUID(), itemType: .standingUnsupportedWithFeetTogether, score: 4),
            BergItem(id: UUID(), itemType: .reachingForwardWithOutstrechedArmWhileStanding, score: 3),
            BergItem(id: UUID(), itemType: .turningToLookBehindOverLeftAndRightShoulders, score: 4)
        ]
    )
}

extension BergItem {

    static let mockItems: [BergItem] = [
        BergItem(
            id: UUID(),
            itemType: .sittingToStanding,
            score: 0,
            timeRecorded: nil
        ),
        BergItem(
            id: UUID(),
            itemType: .standingToSitting,
            score: 0,
            timeRecorded: nil
        ),
        BergItem(
            id: UUID(),
            itemType: .sittingWithBackUnsupported,
            score: 0,
            timeRecorded: nil
        )
    ]
}
