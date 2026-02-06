//
//  TrunkControlTestInfo.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 6/2/26.
//

import Foundation

extension ClinicalTestInfo {
    static let trunkControlTest = ClinicalTestInfo(
        testType: .trunkControlTest,
        description: "El trunk control test evalua el control y la estabilidad de tronco mediante cuatro movimientos funcionales destinados a media la capacidad del paciente para iniciar y realizar control de tronco sin asistencia.",
        materials: ["Camilla"],
        scoring: "Cuatro ítems, cada uno puntuado con 0, 12 o 25. La puntuación total es la suma de los cuatro, con un rango de 0 (peor control) a 100 (mejor control).",
        interpretation: "Una puntuación total más alta indica mejor control del tronco. El TCT se utiliza para evaluar la función postural en pacientes con alteraciones neurológicas (por ejemplo, ictus o lesión medular). Mejores puntuaciones se correlacionan con mayor independencia y capacidad funcional, incluyendo la probabilidad de caminar de manera independiente.",
        recommendations: "El TCT puede ser utilizado para guiar el plan de rehabilitación dirigido a mejorar el control del tronco y para monitorizar cambios a lo largo del tiempo. Se recomienda su uso como parte de una batería de evaluaciones funcionales del tronco y miembro inferior.",
        referenceURL: URL(string: "https://www.sralab.org/rehabilitation-measures/trunk-control-test")
    )
}
