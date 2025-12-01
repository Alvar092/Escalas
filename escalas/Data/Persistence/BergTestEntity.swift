//
//  BergTestEntity.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation
import SwiftData

@Model
final class BergTestEntity {
    @Attribute(.unique) var id: UUID
    var date: Date
    var patient: PatientEntity?
    var itemsData: Data
    
    init(id: UUID, date: Date, patient: PatientEntity? = nil, itemsData: Data) {
        self.id = id
        self.date = date
        self.patient = patient
        self.itemsData = itemsData
    }
}
