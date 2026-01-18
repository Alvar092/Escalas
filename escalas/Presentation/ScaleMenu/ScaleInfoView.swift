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
                    .font(.title)
                    .bold()
                
                Text("Descripción:")
                    .font(.title3)
                    .bold()
                Text(info.description)
                
                if let materials = info.materials{
                    Text("Materiales:")
                        .font(.title3)
                        .bold()

                    ForEach(materials, id: \.self ){ material in
                        Text("-\(material)")
                        
                    }
                } //Materials
                
                Text("Calificación:")
                    .font(.title3)
                    .bold()
                Text(info.scoring)
                    
                Text("Interpretación:")
                    .font(.title3)
                    .bold()
                Text(info.interpretation)
                
                if let recommendations = info.recommendations {
                    Text("Recomendaciones:")
                        .font(.title3)
                        .bold()
                    Text(recommendations)
                }
                
                
                Text("Referencias bibliográficas:")
                    .font(.title3)
                    .bold()
                
                if let referenceURL = info.referenceURL {
                    Link("SraLab",destination: referenceURL)
                        .font(.footnote)
                }
            }// VStack
            .padding(16)
        }
    }
}

#Preview {
    ScaleInfoView(info: ClinicalTestInfo.berg)
}
