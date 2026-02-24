//
//  AnalyticsManager.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 24/2/26.
//

import Foundation
import FirebaseAnalytics

enum AnalyticsEvent {
    case appOpened
    case patientCreated
    case testOpened(test: TestType)
    case testCompleted(test: TestType, score: Int)
    case pdfExported(test: TestType)
}


struct AnalyticsManager {
    static func log(_ event: AnalyticsEvent) {
            switch event {
            case .appOpened:
                Analytics.logEvent("app_opened", parameters: nil)
                
            case .patientCreated:
                Analytics.logEvent("patient_created", parameters: nil)
                
            case .testOpened(let test):
                Analytics.logEvent("test_opened", parameters: ["test_name": test.rawValue])
                
            case .testCompleted(let test, let score):
                Analytics.logEvent("test_completed", parameters: [
                    "test_name": test.rawValue,
                    "score": score
                ])
                
            case .pdfExported(let test):
                Analytics.logEvent("pdf_exported", parameters: ["test_name": test.rawValue])
            }
        }
}
