//
//  MotorIndexRepository.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation

protocol MotricityIndexRepositoryProtocol {
    func save(_ test: MotricityIndex) async throws
    func getAll() async throws -> [MotricityIndex]
    func getByPatient(_ patientID: UUID) async throws -> [MotricityIndex]
    func getByID(_ id: UUID) async throws -> MotricityIndex?
    func update(_ test: MotricityIndex) async throws
}
