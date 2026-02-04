//
//  PDFGenerator.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import PDFKit

class PDFGenerator {
    // Tamaño de página
    
    
    private let pageWidth:CGFloat = 595.2
    private let pageHeight: CGFloat = 841.8
    private let margin: CGFloat = 50
    
    
    func generatePDF(test: ClinicalTestProtocol, patient: Patient, items: [BergItemPDF]) ->Data {
        // Metadatos del PDF(autor, título, creador)
        let pdfMetaData = [
            kCGPDFContextCreator: "App Escalas",
            kCGPDFContextTitle: "Evaluación \(test.testType)"
        ]
        
        // Configurar formato
        let format = UIGraphicsPDFRendererFormat() // objeto que configura como se genera el PDF
        format.documentInfo = pdfMetaData as [String: Any] // Asignar metadatos
        
        // Tamaño página y renderer
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        // Generar el contenido del PDF. pdfData es un closure que genera donde dibujamos todo
        let data = renderer.pdfData { context in
            var currentPage = 1
            //Comenzar nueva página
            context.beginPage()
            
            // Altura
            var currentY: CGFloat = margin
            
            // Encabezado
            currentY = drawTitle(testName: test.name, y: currentY)
            currentY += 15
            
            // Datos del paciente
            currentY = drawSection(title: "Datos del paciente", y: currentY)
            currentY = drawPatientData(patient: patient, y: currentY)
            
            // Info de la prueba
            currentY = drawSection(title: "Información de la evaluación", y: currentY)
            currentY = drawText(text: "Fecha: \(formatDate(test.date))", y: currentY)
            currentY += 20
            
            // Puntuación total
            currentY = drawTotalScore(
                score: test.totalScore,
                maxScore: test.maxScore ?? 0,
                y: currentY
            )
            currentY += 30
            
            //Items del test
            if let bergTest = test as? BergTest {
                currentY = drawSection(title: "Detalle de Items", y: currentY)
                currentY += 10
                
                for item in items {
                    if currentY > pageHeight - 150 {
                        drawPageNumber(number: currentPage, context: context)
                        context.beginPage()
                        currentPage += 1
                        currentY = margin
                    }
                    
                    currentY = drawItem(item: item, y: currentY)
                    currentY += 8
                }
            }
            drawPageNumber(number: currentPage, context: context)
        }
        
        return data
    }
    
    // MARK: Funciones de dibujado
    private func drawTitle(testName: String, y: CGFloat) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 26),
            .foregroundColor: UIColor(red: 0.2, green: 0.3, blue: 0.5 , alpha: 1.0)
        ]
        
        let textSize = testName.size(withAttributes: attrs)
        let textRect = CGRect(
            x: (pageWidth - textSize.width) / 2,
            y: y,
            width: textSize.width,
            height: textSize.height
        )
        
        testName.draw(in: textRect, withAttributes: attrs)
        
        // Linea debajo del título
        let lineY = y + textSize.height + 5
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: margin, y: lineY))
        linePath.addLine(to: CGPoint(x: pageWidth - margin, y: lineY))
        UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1.0).setStroke()
        linePath.lineWidth = 2
        linePath.stroke()
        
        return lineY + 5
    }
    
    
    private func drawPatientData(patient: Patient, y: CGFloat) -> CGFloat {
        var currentY = y
        
        currentY = drawText(text: "Nombre: \(patient.name)", y: currentY)
        
        let dob = patient.dateOfBirth
        let age = calculateAge(from: dob)
        currentY = drawText(
            text: "Fecha de nacimiento: \(formatDate(dob))",
            y: currentY
        )
        
        currentY = drawText(text: "Edad: \(age) años", y: currentY)
        
        return currentY
    }
    
    private func drawTotalScore(score: Int, maxScore: Int, y: CGFloat) -> CGFloat {
        // Rectángulo de fondo
        let boxRect = CGRect(x: margin, y: y, width: pageWidth - 2 * margin, height: 80)
        
        // Color de fondo según la puntuación
        let percentage = Double(score) / Double(maxScore)
        let backgroundColor: UIColor
        
        // TODO: MODIFICAR SEGUN LOS BAREMOS DE DEPENDENCIA
        if percentage >= 0.8 {
            backgroundColor = UIColor(red: 0.9, green: 0.98, blue: 0.9, alpha: 1.0) // Verde claro
        } else if percentage >= 0.5 {
            backgroundColor = UIColor(red: 0.98, green: 0.95, blue: 0.9, alpha: 1.0) // Amarillo claro
        } else {
            backgroundColor = UIColor(red: 0.98, green: 0.9, blue: 0.9, alpha: 1.0) // Rojo claro
        }
        
        backgroundColor.setFill()
        UIBezierPath(roundedRect: boxRect, cornerRadius: 12).fill()
        
        // Borde
        UIColor.lightGray.setStroke()
        let borderPath = UIBezierPath(roundedRect: boxRect, cornerRadius: 12)
        borderPath.lineWidth = 1
        borderPath.stroke()
        
        // Texto "Puntuación Total"
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
        
        // Puntuación grande
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
    
    private func drawItem(item: BergItemPDF, y: CGFloat) -> CGFloat {
        let itemWidth = pageWidth - 2 * margin
        let itemHeight: CGFloat = 120 // Más altura para las opciones
        
        // Fondo alternado
        if item.number % 2 == 0 {
            UIColor(white: 0.97, alpha: 1.0).setFill()
            UIBezierPath(rect: CGRect(x: margin, y: y, width: itemWidth, height: itemHeight)).fill()
        }
        
        // Número del ítem
        let numberAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor(red: 0.3, green: 0.4, blue: 0.6, alpha: 1.0)
        ]
        let numberText = "\(item.number)."
        let numberRect = CGRect(x: margin + 10, y: y + 10, width: 30, height: 20)
        numberText.draw(in: numberRect, withAttributes: numberAttrs)
        
        // Título
        let titleAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 11),
            .foregroundColor: UIColor.black
        ]
        let titleRect = CGRect(
            x: margin + 45,
            y: y + 10,
            width: itemWidth - 150 ,
            height: 30
        )
        item.title.draw(in: titleRect, withAttributes: titleAttrs)
                
        
        // Descripcion items e item puntuado
        var currentOptionY = y + 30
        
        for option in item.scoringOptions {
            let optionLineHeight: CGFloat = 14
            let isSelected = option.score == item.score
            
            let optionAttrs: [NSAttributedString.Key : Any] = [
                .font: isSelected
                ? UIFont.boldSystemFont(ofSize: 11)
                : UIFont.systemFont(ofSize: 11),
                .foregroundColor: isSelected
                ? UIColor.black
                : UIColor.darkGray
            ]
            
            let optionText = "\(option.description)"
            let optionRect = CGRect(x: margin + 45, y: currentOptionY, width: itemWidth - 60, height: optionLineHeight)
            
            optionText.draw(in: optionRect, withAttributes: optionAttrs)
            currentOptionY += optionLineHeight
        }
        
        return y + itemHeight
    }
    
    
    
    // MARK: - Funciones auxiliares reutilizables
    
    private func drawSection(title: String, y: CGFloat) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.darkGray
        ]
        
        let textRect = CGRect(x: margin, y: y, width: pageWidth - 2 * margin, height: 25)
        title.draw(in: textRect, withAttributes: attrs)
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: margin, y: y + 23))
        linePath.addLine(to: CGPoint(x: pageWidth - margin, y: y + 23))
        UIColor.lightGray.setStroke()
        linePath.lineWidth = 1
        linePath.stroke()
        
        return y + 35
    }
    
    private func drawText(text: String, y: CGFloat) -> CGFloat {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]
        
        let nsString = text as NSString
        let availableWidth = pageWidth - 2 * margin
        
        // Calcula el tamaño necesario para el texto con saltos de linea
        let boundingRect = nsString.boundingRect(
            with: CGSize(width: availableWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attrs,
            context: nil
        )
        
        let textRect = CGRect(x: margin, y: y, width: availableWidth, height: boundingRect.height)
        nsString.draw(in: textRect, withAttributes: attrs)
        return y + boundingRect.height + 6
    }
    
    private func drawPageNumber(number: Int, context: UIGraphicsPDFRendererContext) {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 9),
            .foregroundColor: UIColor.gray
        ]
        
        let text = "Página \(number)"
        let textSize = text.size(withAttributes: attrs)
        let textRect = CGRect(
            x: pageWidth - margin - textSize.width,
            y: pageHeight - margin + 10,
            width: textSize.width,
            height: textSize.height
        )
        text.draw(in: textRect, withAttributes: attrs)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        //formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "es_ES")
        return formatter.string(from: date)
    }
    
    private func calculateAge(from birthDate: Date) -> Int {
        Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
    }
}
