//
//  CreateBergTestUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 20/1/26.
//

import Foundation

protocol CreateTestUseCaseProtocol {
    func createTest(type: TestType, patientID: UUID) -> ClinicalTestProtocol
}

final class CreateTestUseCase: CreateTestUseCaseProtocol {
    func createTest(type: TestType,patientID: UUID) -> ClinicalTestProtocol {
        
        switch type {
        case .berg:
            let items = BergItemType.allCases.map { type in
                BergItem(
                    id: UUID(),
                    itemType: type,
                    score: nil
                )
            }
            
            return BergTest(
                id: UUID(),
                date: Date(),
                patientID: patientID,
                items: items
            )
            
        }
    }
}
