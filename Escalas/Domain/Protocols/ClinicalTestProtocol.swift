//
//  ClinicalTestProtocol.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import Foundation

enum TestType: String, Codable {
    case berg = "Berg Balance Scale"
    case motricityIndex = "Motricity Index"
    case trunkControlTest = "Trunk Control Test "
    
    var maxScore: Int {
        switch self {
        case .berg: return 56
            
        case .motricityIndex: return 198
            
        case .trunkControlTest: return 100
        }
    }
    
    var displayName: String {
        self.rawValue
    }
}

protocol ClinicalTestProtocol {
    var id: UUID {get}
    var date: Date {get}
    var evaluator: String? {get}
    var patientID: UUID {get}
    var totalScore: Int {get}
    var maxScore: Int? {get}
    var testType: TestType {get}
}

extension ClinicalTestProtocol {
    var name: String {
        testType.displayName
    }
}

extension BergTest {
    var testType: TestType { .berg }
}

extension MotricityIndex {
    var testType: TestType { .motricityIndex}
}

extension TrunkControlTest {
    var testType: TestType { .trunkControlTest}
}
