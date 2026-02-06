//
//  MotorIndexInfo.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 6/2/26.
//

import Foundation

extension ClinicalTestInfo {
    static let motricityIndex = ClinicalTestInfo(
        testType: .motricityIndex,
        description: "El Motricity Index es un método ordinal para medir la fuerza motora en pacientes con hemiparesia tras un accidente cerebrovascular, basado en movimientos seleccionados de extremidades superiores e inferiores para reflejar la capacidad de generar fuerza en grupos musculares clave.",
        materials: ["Cubito de 2.5 cm para pruebas de prensión"],
        scoring: "Seis ítems (3 para extremidad superior: prensión, flexión de codo, abducción de hombro; y 3 para extremidad inferior: dorsiflexión de tobillo, extensión de rodilla y flexión de cadera). Cada componente se evalúa con puntuaciones ponderadas y la suma total varía de 0 a 100.",
        interpretation: "Una puntuación más alta indica mayor fuerza motora global. El Motricity Index se utiliza para evaluar la función motora en pacientes post-ictus y monitorizar la recuperación de fuerza.",
        recommendations: "Usar como parte de la evaluación clínica para planificar intervenciones de rehabilitación centradas en fuerza motora y para seguimiento de la recuperación.",
        referenceURL: URL(string: "https://www.sralab.org/rehabilitation-measures/motricity-index")
    )
}
