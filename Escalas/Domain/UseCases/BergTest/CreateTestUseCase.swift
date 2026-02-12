//
//  CreateBergTestUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 20/1/26.
//

import Foundation

protocol CreateTestUseCaseProtocol {
    func createTest(type: TestType, patientID: UUID, side: BodySide?) -> ClinicalTestProtocol
}

final class CreateTestUseCase: CreateTestUseCaseProtocol {
    func createTest(type: TestType,patientID: UUID, side: BodySide?) -> ClinicalTestProtocol {
        
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
            
        case .motricityIndex:
            let items = MotricityIndexItemType.allCases.map { type in
                MotricityIndexItem(
                    id: UUID(),
                    itemType: type,
                    score: nil
                )
            }
            
            return MotricityIndex(
                id: UUID(),
                date: Date(),
                patientID: patientID,
                side: nil,
                items: items
            )
        case .trunkControlTest:
            let items = TrunkControlItemType.allCases.map {
                TrunkControlTestItem(
                    id: UUID(),
                    itemType: $0,
                    score: nil
                )
            }
            
            return TrunkControlTest(
                id: UUID(),
                date: Date(),
                patientID: patientID,
                items: items
            )
        }
    }
}
