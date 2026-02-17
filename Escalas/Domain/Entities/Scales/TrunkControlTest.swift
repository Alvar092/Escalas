//
//  TrunkControlTest.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation

struct TrunkControlTest: ClinicalTestProtocol, SideTestProtocol {
    var id: UUID
    var date: Date
    var evaluator: String?
    var patientID: UUID
    var side: BodySide?
    var maxScore: Int?
    var items: [TrunkControlTestItem]
    
    var totalScore: Int {
        items.reduce(0) { $0 + ($1.score ?? 0) }
    }
}

struct TrunkControlTestItem: Codable {
    let id: UUID
    let itemType: TrunkControlItemType
    var score: Int?
}

enum TrunkControlItemType: Int, Codable, CaseIterable {
    case rollingToWeakSide = 1
    case rollingToStrongSide = 2
    case balancedSitting = 3
    case sittingUpFromLyingDown = 4
}

