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
            
            VStack(alignment:.center, spacing: 8) {
                HStack(alignment: .center) {
                    Text(viewModel.currentItemDefinition.title)
                        .font(.title2)
                        .bold()
                   
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
                        viewModel.selectScore(option.score)
                    } label: {
                        HStack{
                            Text(option.description)
                                .foregroundStyle(.black.opacity(0.8))
                            
                            Spacer()
                        }
                        .padding(16)
                        
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    viewModel.isOptionSelected(option)
                                    ? Color.blue.opacity(0.2) : Color.clear
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    viewModel.isOptionSelected(option)
                                    ? Color.blue
                                    : Color.blue.opacity(0.7)
                                )
                            )
                    }
                }
            } //VStack Opciones respuestas
            
            Spacer()
            
            HStack {
                Button{
                    viewModel.backItem()
                } label: {
                    Text("Atras")
                }
                
                Spacer()
                
                Text(viewModel.progress)
                    .font(.headline)
                
                Spacer()
                
                Button(viewModel.isLastItem ? "Finalizar" : "Siguiente") {
                    if viewModel.isLastItem {
                        // End()
                    } else {
                        viewModel.nextItem()
                    }
                }
            }
        }//VStack padre
        .padding()
    }
}


#Preview {
    BergTestView(viewModel: BergTestViewModel(test: BergTest.patient1))
}
