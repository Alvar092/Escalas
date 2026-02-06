//
//  TrunkControlTest.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation

struct TrunkControlTest: ClinicalTestProtocol {
    var id: UUID
    var date: Date
    var evaluator: String?
    var patientID: UUID
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
    case rollToWeakSide = 1
    case rollStrongSide = 2
    case balanceSitting = 3
    case sitFromLyingDown = 4
}

