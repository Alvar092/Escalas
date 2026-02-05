//
//  MotorIndexMapper.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation
import SwiftData

extension MotorIndex {
    func toEntity(patientEntity: PatientEntity) throws -> MotorIndexEntity {
        let itemsData = try JSONEncoder().encode(self.items)
        
        return MotorIndexEntity(
            id: self.id,
            date: self.date,
            side: self.side.rawValue,
            patient: patientEntity,
            itemsData: try JSONEncoder().encode(items)
        )
    }
}

extension MotorIndexEntity{
    func toDomain() throws -> MotorIndex {
        let items = try JSONDecoder().decode([MotorIndexItem].self, from: itemsData)
        
        return MotorIndex(
            id: self.id,
            date: self.date,
            patientID: self.patient.id,
            side: BodySide(rawValue: self.side) ?? .right,
            items: items
        )
    }
}
