//
//  MotorIndexInfo.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 6/2/26.
//

import Foundation

extension ClinicalTestInfo {
    static let motricityIndex = ClinicalTestInfo(
        testType: .motricityIndex,
        description: String(localized: "scalesInfo.motricityIndex.description", table: "ScalesInfo"),
        materials: [
            String(localized: "scalesInfo.motricityIndex.material.0", table: "ScalesInfo")
        ],
        scoring: String(localized: "scalesInfo.motricityIndex.scoring", table: "ScalesInfo"),
        interpretation: String(localized: "scalesInfo.motricityIndex.interpretation", table: "ScalesInfo"),
        recommendations: String(localized: "scalesInfo.motricityIndex.recommendations", table: "ScalesInfo"),
        referenceURL: URL(string: "https://www.sralab.org/rehabilitation-measures/motricity-index")
    )
}
