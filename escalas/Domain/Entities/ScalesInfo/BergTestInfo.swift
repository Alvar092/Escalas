//
//  BergTestInfo.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 13/1/26.
//

import Foundation

extension ClinicalTestInfo {
    static let berg = ClinicalTestInfo(
        testType: .berg,
        description: "Es una escala ampliamente usada para valorar el equilibrio estático y dinámico tanto en sedestación como en bipedestación",
        materials: ["Cronómetro", "Silla de entre 45 y 50 cm con repasobrazos", "Silla de entre 45 y 50 cm sin repasobrazos", "Escalón/cajón de entre 20 y 23 cm", "Regla", "Una zapatilla"],
        scoring: "Cada item puntua de 0 a 4. Una puntuación de 0 indica incapacidad para realizar la tarea y una puntuación de 4 indica capacidad para poder hacer la tarea./nLos items puntuan en relación al tiempo, nivel de independencia o supervisión requerida. Si el paciente necesita supervisión o asistencia, esto se verá reflejado en la puntuación negativamente./n",
        interpretation: "De 0 a 20: Precisa de silla de ruedas./nDe 21 a 40: Puede caminar con ayuda./nDe 41 a 56: Independiente",
        recommendations: "Para apreciar cambios, es aconsejable realizar la prueba al menos 2 veces y, a ser posible, bajo las mismas condiciones.",
        referenceURL: URL(string: "https://www.sralab.org/rehabilitation-measures/berg-balance-scale")
    )
}
