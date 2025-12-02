//
//  PatientMapper.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 2/12/25.
//

import Foundation

extension Patient {
    func toEntity() throws -> PatientEntity {
        return PatientEntity(
            id: self.id,
            name: self.name,
            dateOfBirth: self.dateOfBirth
        )
    }
}

extension PatientEntity {
    func toDomain() throws -> Patient {
        return Patient(
            id: self.id,
            name: self.name,
            dateOfBirth: self.dateOfBirth
        )
    }
}
