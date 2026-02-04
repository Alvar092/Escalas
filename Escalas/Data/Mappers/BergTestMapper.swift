//
//  BergTestMapper.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation
import SwiftData

extension BergTest {
    func toEntity(patientEntity: PatientEntity) throws -> BergTestEntity {
        let itemsData = try JSONEncoder().encode(self.items)
        
        return BergTestEntity(
            id: self.id,
            date: self.date,
            patient: patientEntity,
            itemsData: itemsData
            )
    }
}

extension BergTestEntity {
    func toDomain() throws -> BergTest {
        let items = try JSONDecoder().decode([BergItem].self, from: itemsData)
        return BergTest(
            id: self.id,
            date: self.date,
            patientID: self.patient.id,
            items: items
        )
    }
}
