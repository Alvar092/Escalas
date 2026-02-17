//
//  SideTestProtocol.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 17/2/26.
//

import Foundation

protocol SideTestProtocol {
    var side: BodySide? { get }
}

// MARK: - BodySide Display
extension BodySide {
    var displayName: String {
        switch self {
        case .right: return "Derecho"
        case .left:  return "Izquierdo"
        }
    }
}
