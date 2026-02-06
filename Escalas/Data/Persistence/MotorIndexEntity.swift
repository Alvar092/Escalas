//
//  MotorIndexEntity.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation
import SwiftData

@Model
final class MotricityIndexEntity {
    @Attribute(.unique) var id: UUID
    var date: Date
    var side: String
    var patient: PatientEntity
    var itemsData: Data
    
    init(
        id: UUID,
        date: Date,
        side: String,
        patient: PatientEntity,
        itemsData: Data
    ) {
        self.id = id
        self.date = date
        self.side = side
        self.patient = patient
        self.itemsData = itemsData
    }
}
