//
//  ClinicalTestProtocol.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import Foundation

enum TestType: String, Codable {
    case berg = "Berg Balance Scale"
    
    var maxScore: Int {
        switch self {
        case .berg: return 56
        }
    }
    
    var displayName: String {
        self.rawValue
    }
}

protocol ClinicalTestProtocol {
    var id: UUID {get}
    var date: Date {get}
    var patientID: UUID {get}
    var totalScore: Int {get}
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


