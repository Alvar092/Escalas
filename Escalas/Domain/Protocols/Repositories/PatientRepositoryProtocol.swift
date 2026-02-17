//
//  PatientRepositoryProtocol.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation

protocol PatientRepositoryProtocol {
    func save(_ patient: Patient) async throws
    func getAll() async throws -> [Patient]
    func getByID(_ id: UUID) async throws -> Patient?
    func delete(_ id: UUID) async throws
    func update(_ patient: Patient) async throws
}
