//
//  PatientEntity.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation
import SwiftData

@Model
final class PatientEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var dateOfBirth: Date

    @Relationship(deleteRule: .cascade, inverse: \BergTestEntity.patient)
    var tests: [BergTestEntity]?
    
    init(id: UUID, name: String, dateOfBirth: Date, tests: [BergTestEntity]? = nil) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.tests = tests
    }
}
