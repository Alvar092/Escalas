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
    let side: BodySide
    var maxScore: Int?
    var items: [TrunkControlTestItem]
    
    var totalScore: Int {
        items.reduce(0) { $0 + $1.score }
    }
}

struct TrunkControlTestItem: Codable {
    let id: UUID
    let itemType: TrunkControlItemType
    var score: Int 
}

enum TrunkControlItemType: String, Codable, CaseIterable {
    case rollToWeakSide
    case rollStrongSide
    case balanceSitting
    case sitFromLyingDown
}

