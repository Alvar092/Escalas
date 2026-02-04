//
//  ClinicalTestInfoProtocol.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 13/1/26.
//

protocol ClinicalTestInfoProtocol {
    func info(for testType: TestType) -> ClinicalTestInfo
}
