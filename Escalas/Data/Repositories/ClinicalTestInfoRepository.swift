//
//  ClinicalTestInfoRepository.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 13/1/26.
//

import Foundation

final class ClinicalTestInfoRepository: ClinicalTestInfoProtocol {
    func info(for testType: TestType) -> ClinicalTestInfo {
        switch testType {
        case .berg:
            return .berg
        }
    }
    
    
}
