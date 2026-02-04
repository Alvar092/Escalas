//
//  Patient.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//
import Foundation

struct Patient: Hashable {
    var id: UUID
    var name: String
    var dateOfBirth: Date
    
    var age: Int {
        let calendar = Calendar.current
        let now = Date()
        
        return calendar.dateComponents(
            [.year],
            from: dateOfBirth,
            to: now
        ).year ?? 0
    }
}

