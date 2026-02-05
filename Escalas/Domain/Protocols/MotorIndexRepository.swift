//
//  MotorIndexRepository.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation

protocol MotorIndexRepositoryProtocol {
    func save(_ test: MotorIndex) async throws
    func getAll() async throws -> [MotorIndex]
    func getByPatient(_ patientID: UUID) async throws -> [MotorIndex]
    func getByID(_ id: UUID) async throws -> MotorIndex?
    func update(_ test: MotorIndex) async throws
}
