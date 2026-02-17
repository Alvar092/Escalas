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
                
                Text("Descripción:")
                    .font(.lSemi)
                Text(info.description)
                    .font(.m)
                
                if let materials = info.materials{
                    Text("Materiales:")
                        .font(.lSemi)

                    ForEach(materials, id: \.self ){ material in
                        Text("-\(material)")
                            .font(.m)
                        
                    }
                } //Materials
                
                Text("Calificación:")
                    .font(.lSemi)
                
                Text(info.scoring)
                    .font(.m)
                
                Text("Interpretación:")
                    .font(.lSemi)
                
                Text(info.interpretation)
                    .font(.m)
                
                if let recommendations = info.recommendations {
                    Text("Recomendaciones:")
                        .font(.lSemi)
                    
                    Text(recommendations)
                        .font(.m)
                }
                
                
                Text("Referencias bibliográficas:")
                    .font(.lSemi)
                
                if let referenceURL = info.referenceURL {
                    Link("SraLab",destination: referenceURL)
                        .font(.m)
                }
            }// VStack
            .padding(16)
        }
        .background(Color.backg)
    }
}

#Preview {
    ScaleInfoView(info: ClinicalTestInfo.trunkControlTest)
}
