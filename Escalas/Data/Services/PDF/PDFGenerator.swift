//
//  PDFGenerator.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import PDFKit

class PDFGenerator {
    
    private let layout: PDFLayout
    
    init(layout: PDFLayout = .a4) {
        self.layout = layout
    }
    
    func generatePDF(test: any ClinicalTestProtocol, patient: Patient) -> Data {
        // Select strategy
        let strategy = getStrategy(for: test)
        
        // Metadata
        let pdfMetaData = [
            kCGPDFContextCreator: "App Escalas",
            kCGPDFContextTitle: "Evaluacion \(test.testType.displayName)"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        // Create Render
        let pageRect = CGRect(origin: .zero, size: layout.pageSize)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        // Generate PDF using strategy
        let data = renderer.pdfData { context in
            context.beginPage()
            
            _ = strategy.drawContent(test: test, patient: patient, context: context, layout: layout)
        }
        return data
    }
    
    private func getStrategy(for test: any ClinicalTestProtocol) -> any TestPDFStrategyProtocol {
        switch test.testType {
        case .berg:
            return BergPDFStrategy()
        case .motricityIndex:
            return MotricityIndexPDFStrategy()
        case .trunkControlTest:
            return TrunkControlPDFStrategy()
        }
    }
}
