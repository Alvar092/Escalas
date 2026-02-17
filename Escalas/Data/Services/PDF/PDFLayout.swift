//
//  PDFLayout.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 16/2/26.
//

import Foundation

struct PDFLayout {
    let pageSize: CGSize
    let margin: CGFloat
    
    var contentWidth: CGFloat {
        pageSize.width - (margin * 2)
    }
    
    var contentHeight: CGFloat {
        pageSize.height - (margin * 2)
    }
    
    //Tamaño A4
    static var a4: PDFLayout {
        PDFLayout(pageSize: CGSize(width: 595.2, height: 841.8), margin: 50)
    }
}
