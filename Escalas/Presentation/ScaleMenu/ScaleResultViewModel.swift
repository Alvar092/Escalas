//
//  ScaleResultViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import Foundation
import Observation

@Observable
final class ScaleResultViewModel {
    
    var showShare = false
    var pdfURL: URL?
    var showError = false
    var errorText = ""
    
    private let pdfGenerator = PDFGenerator()
    
    var test: any ClinicalTestProtocol
    private(set) var patient: Patient?
    
    @ObservationIgnored
    private let useCase: GetPatientByIdUseCaseProtocol
    
    init(test: any ClinicalTestProtocol, useCase: GetPatientByIdUseCaseProtocol) {
        self.test = test
        self.useCase = useCase
    }
    
    func getPatient() async throws {
        if let user =  try await useCase.getPatient(by: test.patientID) {
            patient = user
        }
    }
    
    func exportPDF() {
        guard let patient = patient else {
            errorText = "Debe cargar los datos del paciente"
            showError = true
            return
        }
        
        let pdfData = pdfGenerator.generatePDF(
            test: test,
            patient: patient,
        )
        
        let tempURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("test_\(patient.name)_\(Date().timeIntervalSince1970).pdf")
        
        do {
            try pdfData.write(to: tempURL)
            self.pdfURL = tempURL
            self.showShare = true
        } catch {
            self.errorText = "No se pudo generar el PDF: \(error.localizedDescription)"
            self.showError = true
        }
        
    }
    
//    private func prepareItemsForPDF() -> [BergItemPDF] {
//            // Verificar si es BergTest
//            guard let bergTest = test as? BergTest else {
//                return []
//            }
//            
//            // Obtener las definiciones de los items de Berg
//            let definitions = BergItemCatalog.allDefinitions()
//            
//            // Combinar items con sus definiciones
//            var itemsPDF: [BergItemPDF] = []
//            
//            for (index, item) in bergTest.items.enumerated() {
//                // Buscar la definición correspondiente
//                if let definition = definitions.first(where: { $0.type == item.itemType }) {
//                    
//                    let score = item.score ?? 0
//                    let scoreDescription = definition.scoreDescription(for: score)
//                    
//                    let itemPDF = BergItemPDF(
//                        number: index + 1,
//                        definition: definition,
//                        item: item,
//                        test: bergTest,
//                        scoreDescription: scoreDescription
//                    )
//                    itemsPDF.append(itemPDF)
//                }
//            }
//            
//            return itemsPDF
//        }
}
