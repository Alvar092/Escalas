//
//  File.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 13/1/26.
//

import Foundation

struct ClinicalTestInfo {
    let testType: TestType
    let description: String
    let materials: [String]
    let scoring: String
    let interpretation: String
    let recommendations: String?
    let referenceURL: URL?
}
