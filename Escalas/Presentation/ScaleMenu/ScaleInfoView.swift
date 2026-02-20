//
//  BergTestInfoView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/12/25.
//

import SwiftUI

struct ScaleInfoView: View {
    
    let info: ClinicalTestInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(info.name)
                    .font(.xlSemi)
                
                Text(String(localized: "scale.info.description.label", table: "ScaleMenu"))
                    .font(.lSemi)
                Text(info.description)
                    .font(.m)
                
                if let materials = info.materials {
                    Text(String(localized: "scale.info.materials.label", table: "ScaleMenu"))
                        .font(.lSemi)
                    
                    ForEach(materials, id: \.self) { material in
                        Text("-\(material)")
                            .font(.m)
                    }
                }
                
                Text(String(localized: "scale.info.scoring.label", table: "ScaleMenu"))
                    .font(.lSemi)
                Text(info.scoring)
                    .font(.m)
                
                Text(String(localized: "scale.info.interpretation.label", table: "ScaleMenu"))
                    .font(.lSemi)
                Text(info.interpretation)
                    .font(.m)
                
                if let recommendations = info.recommendations {
                    Text(String(localized: "scale.info.recommendations.label", table: "ScaleMenu"))
                        .font(.lSemi)
                    Text(recommendations)
                        .font(.m)
                }
                
                Text(String(localized: "scale.info.references.label", table: "ScaleMenu"))
                    .font(.lSemi)
                
                if let referenceURL = info.referenceURL {
                    Link("SraLab", destination: referenceURL)
                        .font(.m)
                }
            }
            .padding(16)
        }
        .background(Color.backg)
    }
}

#Preview{
    ScaleInfoView(info: ClinicalTestInfo.trunkControlTest)
        .environment(\.locale, Locale(identifier: "en"))
}
