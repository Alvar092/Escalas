//
//  TrunkControlTestInfo.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 6/2/26.
//

import Foundation

extension ClinicalTestInfo {
    static let trunkControlTest = ClinicalTestInfo(
        testType: .trunkControlTest,
        description: String(localized: "scalesInfo.trunkControlTest.description", table: "ScalesInfo"),
        materials: [
            String(localized: "scalesInfo.trunkControlTest.material.0", table: "ScalesInfo")
        ],
        scoring: String(localized: "scalesInfo.trunkControlTest.scoring", table: "ScalesInfo"),
        interpretation: String(localized: "scalesInfo.trunkControlTest.interpretation", table: "ScalesInfo"),
        recommendations: String(localized: "scalesInfo.trunkControlTest.recommendations", table: "ScalesInfo"),
        referenceURL: URL(string: "https://www.sralab.org/rehabilitation-measures/trunk-control-test")
    )
}
