//
//  MotorIndexMapper.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation
import SwiftData

enum MotricityIndexMappingError: Error {
    case missingSide
}

extension MotricityIndex {
    func toEntity(patientEntity: PatientEntity) throws -> MotricityIndexEntity {
        let itemsData = try JSONEncoder().encode(self.items)
        guard let side = self.side else { throw MotricityIndexMappingError.missingSide }
        
        return MotricityIndexEntity(
            id: self.id,
            date: self.date,
            side: side.rawValue,
            patient: patientEntity,
            itemsData: itemsData
        )
    }
}

extension MotricityIndexEntity{
    func toDomain() throws -> MotricityIndex {
        let items = try JSONDecoder().decode([MotricityIndexItem].self, from: itemsData)
        
        return MotricityIndex(
            id: self.id,
            date: self.date,
            patientID: self.patient.id,
            side: BodySide(rawValue: self.side) ?? .right,
            items: items
        )
    }
}
