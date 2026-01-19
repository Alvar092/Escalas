//
//  BergTestFormView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//

import SwiftUI

struct BergTestView: View {
    
    @State var viewModel: BergTestViewModel
    
    
    var body: some View {
        VStack(spacing: 24) {
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(viewModel.currentItemDefinition.title)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Text(viewModel.progress)
                        .font(.headline)
                }
                
                Text(viewModel.currentItemDefinition.description)
            } //VStack Pregunta y marcador
            
            HStack {
                Text("Total:\(viewModel.totalScore)/56")
                    .font(.headline)
            } //HStack Marcador
            Spacer()
            VStack {
                ForEach(viewModel.scoreOptions) { option in
                    Button {
                        
                    } label: {
                        HStack{
                            Text(option.description)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            if viewModel.currentItemScore == option.score {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        .padding(16)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .stroke(viewModel.currentItemScore == option.score ? Color.blue : Color.gray))
                    }
                }
            } //VStack Opciones respuestas
            
            Spacer()
            HStack {
                Button{
                    // Back()
                } label: {
                    Text("Atras")
                }
                Spacer()
                
                Button(viewModel.isLastItem ? "Finalizar" : "Siguiente") {
                    if viewModel.isLastItem {
                        // End()
                    } else {
                        // Next()
                    }
                }
            }
         
        }//VStack padre
        .padding()
    }
}


#Preview {
    BergTestView(viewModel: BergTestViewModel(items: BergItem.mockItems, currentItemIndex: 0))
}
