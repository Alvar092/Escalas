//
//  BergPDFStrategy.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 16/2/26.
//

import Foundation
import PDFKit

class BergPDFStrategy: TestPDFStrategyProtocol {
    
    func drawContent(
        test: any ClinicalTestProtocol,
        patient: Patient,
        context: UIGraphicsPDFRendererContext,
        layout: PDFLayout
    ) -> CGFloat {
        // 1. VALIDAR que es un BergTest
        guard let bergTest = test as? BergTest else {
            return layout.margin
        }
        
        var currentY: CGFloat = layout.margin
        var currentPage = 1
        
        // 2. ENCABEZADO
        currentY = drawHeader(
            testName: test.name,
            y: currentY,
            layout: layout
        )
        currentY += 15
        
        // 3. DATOS DEL PACIENTE
        currentY = drawSection(title: "Datos del Paciente", y: currentY, layout: layout)
        currentY = drawPatientData(patient: patient, y: currentY, layout: layout)
        currentY += 20
        
        // 4. INFORMACIÓN DE LA EVALUACIÓN
        currentY = drawSection(title: "Información de la Evaluación", y: currentY, layout: layout)
        currentY = drawText(text: "Fecha: \(formatDate(test.date))", y: currentY, layout: layout)
        currentY += 20
        
        // 5. PUNTUACIÓN TOTAL
        currentY = drawTotalScore(
            score: test.totalScore,
            maxScore: test.maxScore ?? 56,
            y: currentY,
            layout: layout
        )
        currentY += 30
        
        // 6. PREPARAR ITEMS PARA PDF
        let itemsPDF = prepareItemsForPDF(bergTest: bergTest)
        
        // 7. DIBUJAR ITEMS
        currentY = drawSection(title: "Detalle de Ítems", y: currentY, layout: layout)
        currentY += 10
        
        for item in itemsPDF {
            // Verificar si necesitamos nueva página
            if currentY > layout.pageSize.height - 150 {
                drawPageNumber(number: currentPage, layout: layout, context: context)
                context.beginPage()
                currentPage += 1
                currentY = layout.margin
            }
            
            currentY = drawItem(item: item, y: currentY, layout: layout)
            currentY += 8
        }
        
        // 8. PIE DE PÁGINA
        drawPageNumber(number: currentPage, layout: layout, context: context)
        
        return currentY
    }
    
    // MARK: - Prepare items
    
    private func prepareItemsForPDF(bergTest: BergTest) -> [BergItemPDF] {
        let definitions = BergItemCatalog.allDefinitions()
        
        return bergTest.items.enumerated().compactMap { (index, item) -> BergItemPDF? in
            guard let definition = definitions.first(where: { $0.type == item.itemType }) else {
                return nil
            }
            
            var scoreDescription = ""
            if let itemScore = item.score {
                if let matchingOption = definition.scoringOptions.first(where: { $0.score == itemScore }) {
                    scoreDescription = matchingOption.description
                }
            }
            return BergItemPDF(
                number: index + 1,
                definition: definition,
                item: item,
                test: bergTest,
                scoreDescription: scoreDescription
            )
        }
    }
    
    // MARK: - Drawing Functions
    
    private func drawHeader(testName: String, y: CGFloat, layout: PDFLayout) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 26),
            .foregroundColor: UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0)
        ]
        
        let textSize = testName.size(withAttributes: attrs)
        let textRect = CGRect(
            x: (layout.pageSize.width - textSize.width) / 2,
            y: y,
            width: textSize.width,
            height: textSize.height
        )
        
        testName.draw(in: textRect, withAttributes: attrs)
        
        // Línea debajo del título
        let lineY = y + textSize.height + 5
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: layout.margin, y: lineY))
        linePath.addLine(to: CGPoint(x: layout.pageSize.width - layout.margin, y: lineY))
        UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0).setStroke()
        linePath.lineWidth = 2
        linePath.stroke()
        
        return lineY + 5
    }
    
    private func drawSection(title: String, y: CGFloat, layout: PDFLayout) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.darkGray
        ]
        
        let textRect = CGRect(
            x: layout.margin,
            y: y,
            width: layout.contentWidth,
            height: 25
        )
        title.draw(in: textRect, withAttributes: attrs)
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: layout.margin, y: y + 23))
        linePath.addLine(to: CGPoint(x: layout.pageSize.width - layout.margin, y: y + 23))
        UIColor.lightGray.setStroke()
        linePath.lineWidth = 1
        linePath.stroke()
        
        return y + 35
    }
    
    private func drawPatientData(patient: Patient, y: CGFloat, layout: PDFLayout) -> CGFloat {
        var currentY = y
        
        currentY = drawText(text: "Nombre: \(patient.name)", y: currentY, layout: layout)
        
        let age = calculateAge(from: patient.dateOfBirth)
        
        currentY = drawText(
            text: "Edad: \(age) años",
            y: currentY,
            layout: layout
        )
        
        return currentY
    }
    
    private func drawText(text: String, y: CGFloat, layout: PDFLayout) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]
        
        let textRect = CGRect(
            x: layout.margin,
            y: y,
            width: layout.contentWidth,
            height: 18
        )
        text.draw(in: textRect, withAttributes: attrs)
        return y + 22
    }
    
    private func drawTotalScore(score: Int, maxScore: Int, y: CGFloat, layout: PDFLayout) -> CGFloat {
        let boxRect = CGRect(
            x: layout.margin,
            y: y,
            width: layout.contentWidth,
            height: 80
        )
        
        // Color según puntuación
        let percentage = Double(score) / Double(maxScore)
        let backgroundColor: UIColor
        if percentage >= 0.8 {
            backgroundColor = UIColor(red: 0.9, green: 0.98, blue: 0.9, alpha: 1.0)
        } else if percentage >= 0.5 {
            backgroundColor = UIColor(red: 0.98, green: 0.95, blue: 0.9, alpha: 1.0)
        } else {
            backgroundColor = UIColor(red: 0.98, green: 0.9, blue: 0.9, alpha: 1.0)
        }
        
        backgroundColor.setFill()
        UIBezierPath(roundedRect: boxRect, cornerRadius: 12).fill()
        
        UIColor.lightGray.setStroke()
        let borderPath = UIBezierPath(roundedRect: boxRect, cornerRadius: 12)
        borderPath.lineWidth = 1
        borderPath.stroke()
        
        // Label
        let labelAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.darkGray
        ]
        let label = "Puntuación Total"
        let labelSize = label.size(withAttributes: labelAttrs)
        let labelRect = CGRect(
            x: boxRect.midX - labelSize.width / 2,
            y: boxRect.minY + 15,
            width: labelSize.width,
            height: labelSize.height
        )
        label.draw(in: labelRect, withAttributes: labelAttrs)
        
        // Score
        let scoreAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 36),
            .foregroundColor: UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0)
        ]
        let scoreText = "\(score) / \(maxScore)"
        let scoreSize = scoreText.size(withAttributes: scoreAttrs)
        let scoreRect = CGRect(
            x: boxRect.midX - scoreSize.width / 2,
            y: boxRect.midY - scoreSize.height / 2 + 5,
            width: scoreSize.width,
            height: scoreSize.height
        )
        scoreText.draw(in: scoreRect, withAttributes: scoreAttrs)
        
        return y + boxRect.height
    }
    
    private func drawItem(item: BergItemPDF, y: CGFloat, layout: PDFLayout) -> CGFloat {
        let itemHeight: CGFloat = 120
        
        // Fondo alternado
        if item.number % 2 == 0 {
                 UIColor(white: 0.97, alpha: 1.0).setFill()
                 UIBezierPath(rect: CGRect(
                     x: layout.margin,
                     y: y,
                     width: layout.contentWidth,
                     height: itemHeight
                 )).fill()
             }
        
        // Número
        let numberAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor(red: 0.3, green: 0.4, blue: 0.6, alpha: 1.0)
        ]
        let numberText = "\(item.number)."
        let numberRect = CGRect(x: layout.margin + 10, y: y + 10, width: 30, height: 20)
        numberText.draw(in: numberRect, withAttributes: numberAttrs)
        
        // Título
        let titleAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 11),
            .foregroundColor: UIColor.black
        ]
        let titleRect = CGRect(
            x: layout.margin + 45,
            y: y + 10,
            width: layout.contentWidth - 150,
            height: 30
        )
        item.title.draw(in: titleRect, withAttributes: titleAttrs)
        
        // Answer options (chosen one in black)
        var currentOptionY = y + 30
                
                for option in item.scoringOptions {
                    let optionLineHeight: CGFloat = 14
                    let isSelected = option.score == item.score
                    
                    let optionAttrs: [NSAttributedString.Key: Any] = [
                        .font: isSelected
                            ? UIFont.boldSystemFont(ofSize: 11)
                            : UIFont.systemFont(ofSize: 11),
                        .foregroundColor: isSelected
                            ? UIColor.black
                            : UIColor.darkGray
                    ]
                    
                    option.description.draw(
                        in: CGRect(
                            x: layout.margin + 45,
                            y: currentOptionY,
                            width: layout.contentWidth - 60,
                            height: optionLineHeight
                        ),
                        withAttributes: optionAttrs
                    )
                    currentOptionY += optionLineHeight
                }
        
        return y + itemHeight
    }
    
    private func drawPageNumber(number: Int, layout: PDFLayout, context: UIGraphicsPDFRendererContext) {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 9),
            .foregroundColor: UIColor.gray
        ]
        
        let texto = "Página \(number)"
        let textSize = texto.size(withAttributes: attrs)
        let textRect = CGRect(
            x: layout.pageSize.width - layout.margin - textSize.width,
            y: layout.pageSize.height - layout.margin + 10,
            width: textSize.width,
            height: textSize.height
        )
        texto.draw(in: textRect, withAttributes: attrs)
    }
    
    // MARK: - Helper Functions
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "es_ES")
        return formatter.string(from: date)
    }
    
    private func formatDateOnly(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "es_ES")
        return formatter.string(from: date)
    }
    
    private func calculateAge(from birthDate: Date) -> Int {
        Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
    }
}
