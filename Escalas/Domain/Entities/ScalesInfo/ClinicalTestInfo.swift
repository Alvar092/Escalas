//
//  File.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 13/1/26.
//

import Foundation

struct ClinicalTestInfo: Equatable {
    let testType: TestType
    let description: String
    let materials: [String]?
    let scoring: String
    let interpretation: String
    let recommendations: String?
    let referenceURL: URL?
    
    var name: String {
        switch self.testType {
        case .berg:
            return String(localized: "Berg Balance Scale", table: "ScalesInfo")
        case .motricityIndex:
            return String(localized: "Motricity Index", table: "ScalesInfo")
        case .trunkControlTest:
            return String(localized: "Trunk Control Test", table: "ScalesInfo")
        }
    }
}

extension TestType {
    var clinicalInfo: ClinicalTestInfo {
        switch self {
        case .berg:
            return ClinicalTestInfo.berg
        case .motricityIndex:
            return ClinicalTestInfo.motricityIndex
        case .trunkControlTest:
            return ClinicalTestInfo.trunkControlTest
        }
    }
}
