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
        switch self {
        case .berg:
            return "Berg Balance Scale"
        default:
            return "Scale name"
        }
    }
}

extension TestType {
    var clinicalInfo: ClinicalTestInfo {
        switch self {
        case .berg:
            return ClinicalTestInfo.berg
        }
    }
}
