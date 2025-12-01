//
//  File.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//


extension BergTest {
    func toEntity(context: ModelContext) throws -> BergTestEntity {
        let itemsData = try JSONEncoder().encode(self.items)
        
        // Look for patient
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == self.patientID }
        )
        let patientEntity = try context.fetch(descriptor).first
        
        return BergTestEntity(
            id: self.id,
            date: self.date,
            patient: patientEntity,
            itemsData: itemsData
            )
    }
}