//
//  BergTestRespositoryProtocol.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation

protocol BergTestRepositoryProtocol {
    func save(_ test: BergTest) async throws
    func getAll() async throws -> [BergTest]
    func getByPatient(_ patientID: UUID) async throws -> [BergTest]
    func getByID(_ id: UUID) async throws -> BergTest?
    func update(_ test: BergTest) async throws
}
