//
//  BergItemCatalog.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/1/26.
//

import Foundation

enum BergItemCatalog {

    static let definitions: [BergItemType: BergItemDefinition] = [

        // MARK: - Item 1
        .sittingToStanding: BergItemDefinition(
            type: .sittingToStanding,
            title: "De sentado a de pie",
            description: "El paciente se levanta desde una silla de altura estándar con reposabrazos, intentando no usar las manos para apoyarse.",
            scoringOptions: [
                .init(score: 4, description: "4. Se levanta sin usar las manos y se estabiliza de forma independiente."),
                .init(score: 3, description: "3. Se levanta de forma independiente usando las manos."),
                .init(score: 2, description: "2. Se levanta usando las manos tras varios intentos."),
                .init(score: 1, description: "1. Necesita ayuda mínima para levantarse o estabilizarse."),
                .init(score: 0, description: "0. Necesita ayuda moderada o máxima para levantarse.")
            ],
            needsTimer: false
        ),

        // MARK: - Item 2
        .standingUnsupported: BergItemDefinition(
            type: .standingUnsupported,
            title: "Bipedestación sin apoyo",
            description: "El paciente permanece de pie sin apoyo, con los pies separados al ancho de los hombros, durante dos minutos.",
            scoringOptions: [
                .init(score: 4, description: "4. Permanece de pie de forma segura durante 2 minutos."),
                .init(score: 3, description: "3. Permanece de pie 2 minutos bajo supervisión."),
                .init(score: 2, description: "2. Permanece de pie 30 segundos sin apoyo."),
                .init(score: 1, description: "1. Necesita varios intentos para mantenerse 30 segundos sin apoyo."),
                .init(score: 0, description: "0. No puede mantenerse de pie 30 segundos sin apoyo.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 3
        .sittingWithBackUnsupported: BergItemDefinition(
            type: .sittingWithBackUnsupported,
            title: "Sedestación sin apoyo de espalda",
            description: "El paciente permanece sentado sin apoyo de espalda, con los brazos cruzados y los pies apoyados, durante dos minutos.",
            scoringOptions: [
                .init(score: 4, description: "4. Permanece sentado de forma segura durante 2 minutos."),
                .init(score: 3, description: "3. Permanece sentado 2 minutos bajo supervisión."),
                .init(score: 2, description: "2. Permanece sentado 30 segundos."),
                .init(score: 1, description: "1. Permanece sentado 10 segundos."),
                .init(score: 0, description: "0. No puede permanecer sentado sin apoyo durante 10 segundos.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 4
        .standingToSitting: BergItemDefinition(
            type: .standingToSitting,
            title: "De pie a sentado",
            description: "El paciente pasa de la posición de pie a sentado en una silla con reposabrazos.",
            scoringOptions: [
                .init(score: 4, description: "4. Se sienta de forma segura con mínimo uso de las manos."),
                .init(score: 3, description: "3. Controla el descenso utilizando las manos."),
                .init(score: 2, description: "2. Utiliza la parte posterior de las piernas contra la silla para controlar el descenso."),
                .init(score: 1, description: "1. Se sienta de forma independiente pero con descenso no controlado."),
                .init(score: 0, description: "0. Necesita ayuda para sentarse.")
            ],
            needsTimer: false
        ),
        
        // MARK: - Item 5
        .transfers: BergItemDefinition(
            type: .transfers,
            title: "Transferencias",
            description: "Se colocan dos sillas formando aproximadamente 90 grados para realizar una transferencia en pivote (una con reposabrazos y otra sin ellos, o una cama y una silla con reposabrazos). El paciente debe realizar la transferencia en ambas direcciones, desde una superficie sin reposabrazos a otra con reposabrazos y viceversa.",
            scoringOptions: [
                .init(score: 4, description: "4. Realiza la transferencia de forma segura con uso mínimo de las manos."),
                .init(score: 3, description: "3. Realiza la transferencia de forma segura con necesidad clara de usar las manos."),
                .init(score: 2, description: "2. Realiza la transferencia con indicaciones verbales y/o supervisión."),
                .init(score: 1, description: "1. Necesita la ayuda de una persona."),
                .init(score: 0, description: "0. Necesita la ayuda de dos personas o supervisión constante por seguridad.")
            ],
            needsTimer: false
        ),
        
        // MARK: - Item 6
        .standingUnsupportedWithEyesClosed: BergItemDefinition(
            type: .standingUnsupportedWithEyesClosed,
            title: "Bipedestación sin apoyo con ojos cerrados",
            description: "El paciente permanece de pie sin apoyo con los ojos cerrados durante 10 segundos.",
            scoringOptions: [
                .init(score: 4, description: "4. Permanece de pie de forma segura durante 10 segundos."),
                .init(score: 3, description: "3. Permanece de pie 10 segundos bajo supervisión."),
                .init(score: 2, description: "2. Permanece de pie 3 segundos."),
                .init(score: 1, description: "1. No puede mantener la posición 3 segundos pero permanece estable."),
                .init(score: 0, description: "0. Necesita ayuda para evitar la caída.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 7
        .standingUnsupportedWithFeetTogether: BergItemDefinition(
            type: .standingUnsupportedWithFeetTogether,
            title: "Bipedestación sin apoyo con pies juntos",
            description: "El paciente permanece de pie sin apoyo con los pies juntos durante 1 minuto.",
            scoringOptions: [
                .init(score: 4, description: "4. Permanece de pie de forma segura durante 1 minuto."),
                .init(score: 3, description: "3. Permanece de pie 1 minuto bajo supervisión."),
                .init(score: 2, description: "2. Permanece de pie 30 segundos."),
                .init(score: 1, description: "1. Necesita ayuda para adoptar la posición pero puede mantenerla 15 segundos."),
                .init(score: 0, description: "0. No puede mantener la posición sin ayuda.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 8
        .reachingForwardWithOutstrechedArmWhileStanding: BergItemDefinition(
            type: .reachingForwardWithOutstrechedArmWhileStanding,
            title: "Alcance anterior en bipedestación",
            description: "Desde bipedestación, el paciente alcanza hacia delante con el brazo extendido sin perder el equilibrio.",
            scoringOptions: [
                .init(score: 4, description: "4. Alcanza hacia delante más de 25 cm de forma segura."),
                .init(score: 3, description: "3. Alcanza entre 12 y 25 cm."),
                .init(score: 2, description: "2. Alcanza menos de 12 cm."),
                .init(score: 1, description: "1. Alcanza hacia delante pero necesita supervisión."),
                .init(score: 0, description: "0. Pierde el equilibrio o necesita ayuda.")
            ],
            needsTimer: false
        ),

        // MARK: - Item 9
        .PickUpObjectFromTheFloorFromAStandingPosition: BergItemDefinition(
            type: .PickUpObjectFromTheFloorFromAStandingPosition,
            title: "Recoger un objeto del suelo",
            description: "Desde bipedestación, el paciente recoge un objeto del suelo situado delante de sus pies.",
            scoringOptions: [
                .init(score: 4, description: "4. Recoge el objeto de forma segura y fácil."),
                .init(score: 3, description: "3. Recoge el objeto bajo supervisión."),
                .init(score: 2, description: "2. No puede recoger el objeto pero alcanza a tocarlo."),
                .init(score: 1, description: "1. Necesita ayuda para mantener el equilibrio."),
                .init(score: 0, description: "0. No puede intentar la tarea o necesita ayuda.")
            ],
            needsTimer: false
        ),

        // MARK: - Item 10
        .turningToLookBehindOverLeftAndRightShoulders: BergItemDefinition(
            type: .turningToLookBehindOverLeftAndRightShoulders,
            title: "Giro para mirar detrás sobre ambos hombros",
            description: "Desde bipedestación, el paciente gira el tronco para mirar detrás por ambos hombros.",
            scoringOptions: [
                .init(score: 4, description: "4. Mira detrás por ambos lados con buen equilibrio."),
                .init(score: 3, description: "3. Mira detrás por un lado con mayor seguridad que por el otro."),
                .init(score: 2, description: "2. Gira parcialmente pero mantiene el equilibrio."),
                .init(score: 1, description: "1. Necesita supervisión al girar."),
                .init(score: 0, description: "0. Necesita ayuda para evitar la caída.")
            ],
            needsTimer: false
        ),

        // MARK: - Item 11
        .turn360Degrees: BergItemDefinition(
            type: .turn360Degrees,
            title: "Giro de 360 grados",
            description: "El paciente gira completamente sobre sí mismo en ambos sentidos.",
            scoringOptions: [
                .init(score: 4, description: "4. Realiza ambos giros en menos de 4 segundos de forma segura."),
                .init(score: 3, description: "3. Realiza ambos giros de forma segura pero lentamente."),
                .init(score: 2, description: "2. Realiza un giro completo de forma segura."),
                .init(score: 1, description: "1. Necesita supervisión al girar."),
                .init(score: 0, description: "0. Necesita ayuda para girar.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 12
        .PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported: BergItemDefinition(
            type: .PlacingAlternatesFootOnStepOrStoolWhileStandingUnsupported,
            title: "Colocar pies alternos sobre un escalón",
            description: "El paciente coloca alternativamente cada pie sobre un escalón o taburete durante ocho repeticiones.",
            scoringOptions: [
                .init(score: 4, description: "4. Completa 8 repeticiones de forma segura en menos de 20 segundos."),
                .init(score: 3, description: "3. Completa 8 repeticiones de forma independiente."),
                .init(score: 2, description: "2. Completa 4 repeticiones sin ayuda."),
                .init(score: 1, description: "1. Necesita ayuda para completar más de 2 repeticiones."),
                .init(score: 0, description: "0. No puede realizar la tarea.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 13
        .StandingUnsupportedOneFootInFront: BergItemDefinition(
            type: .StandingUnsupportedOneFootInFront,
            title: "Bipedestación con un pie delante del otro",
            description: "El paciente permanece de pie con un pie directamente delante del otro durante 30 segundos.",
            scoringOptions: [
                .init(score: 4, description: "4. Mantiene la posición 30 segundos de forma segura."),
                .init(score: 3, description: "3. Mantiene la posición 30 segundos bajo supervisión."),
                .init(score: 2, description: "2. Mantiene la posición 10 segundos."),
                .init(score: 1, description: "1. Necesita ayuda para adoptar la posición."),
                .init(score: 0, description: "0. No puede mantener la posición.")
            ],
            needsTimer: true
        ),

        // MARK: - Item 14
        .StandingOnOneLeg: BergItemDefinition(
            type: .StandingOnOneLeg,
            title: "Bipedestación sobre un solo pie",
            description: "El paciente permanece de pie apoyado sobre una sola pierna el mayor tiempo posible.",
            scoringOptions: [
                .init(score: 4, description: "4. Mantiene la posición más de 10 segundos."),
                .init(score: 3, description: "3. Mantiene la posición entre 5 y 10 segundos."),
                .init(score: 2, description: "2. Mantiene la posición al menos 3 segundos."),
                .init(score: 1, description: "1. Intenta levantar el pie pero no mantiene la posición."),
                .init(score: 0, description: "0. No puede intentar o necesita ayuda.")
            ],
            needsTimer: true
        )
    ]
}
