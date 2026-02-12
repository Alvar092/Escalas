//
//  TrunkControlTestMapper.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation
import SwiftData

extension TrunkControlTest {
    func toEntity(patientEntity: PatientEntity) throws -> TrunkControlEntity {
        let itemsData = try JSONEncoder().encode(self.items)
        
        return TrunkControlEntity(
            id: self.id,
            date: self.date,
            patient: patientEntity,
            itemsData: itemsData
        )
    }
}

extension TrunkControlEntity {
    func toDomain() throws -> TrunkControlTest {
        let items = try JSONDecoder().decode([TrunkControlTestItem].self, from: itemsData)
        
        return TrunkControlTest(
            id: self.id,
            date: self.date,
            patientID: self.patient.id,
            items: items
        )
    }
}
