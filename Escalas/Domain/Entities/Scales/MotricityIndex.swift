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

struct MotricityIndex: ClinicalTestProtocol, SideTestProtocol {
    var id: UUID
    let date: Date
    var evaluator: String?
    let patientID: UUID
    var side: BodySide?
    var maxScore: Int?
    var items: [MotricityIndexItem]
    
    var totalScore: Int {
        (upperLimbScore + lowerLimbScore) / 2
    }

    var upperLimbScore: Int {
        items.filter {$0.itemType.isUpperLimb}
            .reduce(0) {$0 + ($1.score ?? 0) } + 1
    }
    
    var lowerLimbScore: Int {
        items.filter {$0.itemType.isLowerLimb}
            .reduce(0) { $0 + ($1.score ?? 0) } + 1
    }
   
}

struct MotricityIndexItem: Codable {
    let id: UUID
    let itemType: MotricityIndexItemType
    var score: Int?
}

enum MotricityIndexItemType: Int, Codable, CaseIterable {
    // upper limb
    case pinchGrip = 0
    case elbowFlexion = 1
    case shoulderAbduction = 2
    
    // Lower limb
    case hipFlexion = 3
    case kneeExtension = 4
    case ankleDorsiflexion = 5
}

extension MotricityIndexItemType {
    var isUpperLimb: Bool {
        switch self {
        case .pinchGrip, .elbowFlexion, .shoulderAbduction: return true
        case .hipFlexion, .kneeExtension, .ankleDorsiflexion: return false
        }
    }
    
    var isLowerLimb: Bool { !isUpperLimb }
}
