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
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001") ?? UUID(),
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
        ),
        BergItem(id: UUID(),
                 itemType: .standingUnsupported,
                 score: 0,
                 timeRecorded: nil
                )
    ]
}




extension MotricityIndex {
    static let patient1 = MotricityIndex(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -3, to: .now)!,
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000001") ?? UUID(),
        side: .left,
        items: MotricityIndexItem.mockItems
    )
    static let patient2 = MotricityIndex(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000002") ?? UUID(),
        side: .right,
        items: MotricityIndexItem.mockItems
    )
    
    static let patient3 = MotricityIndex(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: 0, to: .now)!,
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000003") ?? UUID(),
        side: .left,
        items: MotricityIndexItem.mockItems
    )
}

extension MotricityIndexItem {
    static let mockItems: [MotricityIndexItem] = [
        MotricityIndexItem(
            id: UUID(),
            itemType: .ankleDorsiflexion,
            score: 0
        ),
        MotricityIndexItem(
            id: UUID(),
            itemType: .elbowFlexion,
            score: 0
        ),
        MotricityIndexItem(
            id: UUID(),
            itemType: .hipFlexion,
            score: 0
        ),
        MotricityIndexItem(
            id: UUID(),
            itemType: .kneeExtension,
            score: 0
        ),
        MotricityIndexItem(
            id: UUID(),
            itemType: .pinchGrip,
            score: 0
        ),
        MotricityIndexItem(
            id: UUID(),
            itemType: .shoulderAbduction,
            score: 0
        )
    ]
}

extension TrunkControlTest {
    
    static let patient1 = TrunkControlTest(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
        evaluator: "Fisioterapeuta 1",
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000001") ?? UUID(),
        maxScore: 100,
        items: TrunkControlTestItem.mockItems
    )
    
    static let patient2 = TrunkControlTest(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: -1, to: .now)!,
        evaluator: "Fisioterapeuta 2",
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000002") ?? UUID(),
        maxScore: 100,
        items: TrunkControlTestItem.mockItems
    )
    
    static let patient3 = TrunkControlTest(
        id: UUID(),
        date: Calendar.current.date(byAdding: .day, value: 0, to: .now)!,
        evaluator: "Fisioterapeuta 3",
        patientID: UUID(uuidString: "00000000-0000-0000-0000-000000000003") ?? UUID(),
        maxScore: 100,
        items: TrunkControlTestItem.mockItems
    )
}

extension TrunkControlTestItem {
    
    static let mockItems: [TrunkControlTestItem] = [
        TrunkControlTestItem(
            id: UUID(),
            itemType: .rollingToWeakSide,
            score: 0
        ),
        TrunkControlTestItem(
            id: UUID(),
            itemType: .rollingToStrongSide,
            score: 0
        ),
        TrunkControlTestItem(
            id: UUID(),
            itemType: .balancedSitting,
            score: 0
        ),
        TrunkControlTestItem(
            id: UUID(),
            itemType: .sittingUpFromLyingDown,
            score: 0
        )
    ]
}
