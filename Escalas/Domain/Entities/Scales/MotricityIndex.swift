//
//  MotorIndex.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation

enum BodySide: String, Codable {
    case right
    case left
}

struct MotricityIndex: ClinicalTestProtocol {
    var id: UUID
    let date: Date
    var evaluator: String?
    let patientID: UUID
    var side: BodySide?
    var maxScore: Int?
    var items: [MotricityIndexItem]
    
    var totalScore: Int {
        items.reduce(0) { $0 + ($1.score ?? 0) }
    }
}

struct MotricityIndexItem: Codable {
    let id: UUID
    let itemType: MotricityIndexItemType
    var score: Int?
}

enum MotricityIndexItemType: Int, Codable, CaseIterable {
    // upper limb
    case pinchGrip = 1
    case elbowFlexion = 2
    case shoulderAbduction = 3
    
    // Lower limb
    case hipFlexion = 4
    case kneeExtension = 5
    case ankleDorsiflexion = 6
}
