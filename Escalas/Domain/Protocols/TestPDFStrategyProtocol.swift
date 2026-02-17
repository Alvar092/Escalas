//
//  TestPDFStrategyProtocol.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 12/2/26.
//

import Foundation
import PDFKit

protocol TestPDFStrategyProtocol {
    func drawContent(
        test: ClinicalTestProtocol,
        patient: Patient,
        context: UIGraphicsPDFRendererContext,
        layout: PDFLayout
    ) -> CGFloat
}
