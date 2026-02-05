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

struct MotorIndex: ClinicalTestProtocol {
    var id: UUID
    var date: Date
    var evaluator: String?
    var patientID: UUID
    let side: BodySide
    var maxScore: Int?
    var items: [MotorIndexItem]
    
    var totalScore: Int {
        items.reduce(0) { $0 + $1.score }
    }
}

struct MotorIndexItem: Codable {
    let id: UUID
    let itemType: MotorIndexItemType
    var score: Int
}

enum MotorIndexItemType: String, Codable, CaseIterable {
    // upper limb
    case pinchGrip
    case elbowFlexion
    case shoulderAbduction
    
    // Lower limb
    case hipFlexion
    case kneeExtension
    case ankleDorsiflexion
}
