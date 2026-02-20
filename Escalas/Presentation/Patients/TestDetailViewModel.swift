//
//  TestDetailViewModel.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 19/2/26.
//
import Foundation

@Observable
final class TestDetailViewModel {
    
    let test: any ClinicalTestProtocol
    let patient: Patient
    
    var pdfURL: URL?
    var showShare = false
    var showError = false
    var errorText = ""
    
    private let pdfGenerator = PDFGenerator()
    
    init(test: any ClinicalTestProtocol, patient: Patient) {
        self.test = test
        self.patient = patient
    }
    
    var bergItems: [BergItemPDF] {
        guard let bergTest = test as? BergTest else { return [] }
        let definitions = BergItemCatalog.allDefinitions()
        return bergTest.items.enumerated().compactMap { index, item in
            guard let definition = definitions.first(where: { $0.type == item.itemType }) else { return nil }
            let scoreDescription = definition.scoreDescription(for: item.score ?? 0)
            return BergItemPDF(number: index + 1, definition: definition, item: item, test: bergTest, scoreDescription: scoreDescription)
        }
    }
    
    var motricityUpperItems: [MotricityIndexItemPDF] {
        guard let motricityTest = test as? MotricityIndex else { return [] }
        return motricityTest.items
            .filter { $0.itemType.isUpperLimb }
            .enumerated()
            .compactMap { index, item -> MotricityIndexItemPDF? in
            guard let definition = MotricityIndexCatalog.definitions[item.itemType] else { return nil }
            let scoreDescription = definition.scoreDescription(for: item.score ?? 0)
            return MotricityIndexItemPDF(number: index + 1, definition: definition, item: item, scoreDescription: scoreDescription)
        }
    }
    
    var motricityLowerItems: [MotricityIndexItemPDF] {
        guard let motricityTest = test as? MotricityIndex else { return [] }
        let startIndex = motricityUpperItems.count + 1
        return motricityTest.items
            .filter { $0.itemType.isLowerLimb }
            .enumerated()
            .compactMap { index, item -> MotricityIndexItemPDF? in
            guard let definition = MotricityIndexCatalog.definitions[item.itemType] else { return nil }
            let scoreDescription = definition.scoreDescription(for: item.score ?? 0)
            return MotricityIndexItemPDF(number: startIndex + index, definition: definition, item: item, scoreDescription: scoreDescription)
        }
    }
    
    var trunkItems: [TrunkControlItemPDF] {
        guard let trunkTest = test as? TrunkControlTest else { return [] }
        return trunkTest.items
            .enumerated()
            .compactMap { index, item in
            guard let definition = TrunkControlTestCatalog.definitions[item.itemType] else { return nil }
            let scoreDescription = definition.scoreDescription(for: item.score ?? 0)
            return TrunkControlItemPDF(number: index + 1, definition: definition, item: item, scoreDescription: scoreDescription)
        }
    }
    
    func exportPDF() {
        let pdfData = pdfGenerator.generatePDF(test: test, patient: patient)
        
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
}
