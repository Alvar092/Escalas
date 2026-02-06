//
//  TrunkControlTestRepository.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation

protocol TrunkControlTestRepositoryProtocol {
    func save(_ test: TrunkControlTest) async throws
    func getAll() async throws -> [TrunkControlTest]
    func getByPatient(_ patientID: UUID) async throws -> [TrunkControlTest]
    func getByID(_ id: UUID) async throws -> TrunkControlTest?
    func update(_ test: TrunkControlTest) async throws
}
