//
//  ClinicalTestRepositoryProtocol.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 18/2/26.
//

import Foundation

protocol ClinicalTestRepositoryProtocol {
    associatedtype Test: ClinicalTestProtocol
    
    func save(_ test: Test) async throws
    func getAll() async throws -> [Test]
    func getByPatient(_ patientID: UUID) async throws -> [Test]
    func getByID(_ id: UUID) async throws -> Test?
    func update(_ test: Test) async throws
}
