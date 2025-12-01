//
//  BergTestMapper.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation
import SwiftData

extension BergTest {
    func toEntity(context: ModelContext) throws -> BergTestEntity {
        let itemsData = try JSONEncoder().encode(self.items)
        
        // Look for patient
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == self.patientID }
        )
        guard let patientEntity = try context.fetch(descriptor).first else {
            throw NSError(domain: "Patient not found", code: 404)
        }
        
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
