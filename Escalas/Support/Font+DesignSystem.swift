//
//  Font+DesignSystem.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 2/2/26.
//

import SwiftUI

extension Font {
    // MARK: - Regular
    static let xl = Font.system(size: 36, weight: .regular)
    static let l = Font.system(size: 28, weight: .regular)
    static let m = Font.system(size: 18, weight: .regular)
    static let s = Font.system(size: 12, weight: .regular)

    // MARK: - Semibold
    static let xlSemi = Font.system(size: 36, weight: .semibold)
    static let lSemi = Font.system(size: 28, weight: .semibold)
    static let mSemi = Font.system(size: 18, weight: .semibold)
}


/* Para aplicar el Spacing: size * 0.01 */
