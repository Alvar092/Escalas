//
//  BergTestInfo.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 13/1/26.
//

import Foundation

extension ClinicalTestInfo {
    static let berg = ClinicalTestInfo(
        testType: .berg,
        description: String(localized: "scalesInfo.berg.description", table: "ScalesInfo"),
        materials: [
            String(localized: "scalesInfo.berg.material.0", table: "ScalesInfo"),
            String(localized: "scalesInfo.berg.material.1", table: "ScalesInfo"),
            String(localized: "scalesInfo.berg.material.2", table: "ScalesInfo"),
            String(localized: "scalesInfo.berg.material.3", table: "ScalesInfo"),
            String(localized: "scalesInfo.berg.material.4", table: "ScalesInfo"),
            String(localized: "scalesInfo.berg.material.5", table: "ScalesInfo")
        ],
        scoring: String(localized: "scalesInfo.berg.scoring", table: "ScalesInfo"),
        interpretation: String(localized: "scalesInfo.berg.interpretation", table: "ScalesInfo"),
        recommendations: String(localized: "scalesInfo.berg.recommendations", table: "ScalesInfo"),
        referenceURL: URL(string: "https://www.sralab.org/rehabilitation-measures/berg-balance-scale")
    )
}
