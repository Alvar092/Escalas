//
//  PatientDetailView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import SwiftUI

struct PatientDetailView: View {
    @Environment(\.repositories) private var repositories
    
    var viewModel: PatientDetailViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack (spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.secondary)
                
                VStack (alignment: .leading, spacing: 4) {
                    
                    Text(viewModel.patient.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("\(viewModel.patient.age) años")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                }
            } // HStack
            .padding(.horizontal)
            
            Text("Tests")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(viewModel.tests, id: \.id) { test in
                HStack{
                    VStack(alignment: .leading) {
                        Text(test.testType.rawValue)
                            .font(.headline)
                        Text(test.date.formatted(date:.abbreviated, time: .omitted))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Text("\(test.totalScore)/\(test.testType.maxScore)")
                        .font(.title3)
                        .bold()
                }
            }
            .padding()
        } // VStack
        .navigationTitle("Paciente")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

#Preview {
    let mockUseCase = MockGetPatientTestsUseCase()
    
    PatientDetailView(viewModel: PatientDetailViewModel(
        patient: Patient.patient1,
        history: PatientHistory(patient: Patient.patient1, bergTests: [BergTest.patient1]),
        getTestsUseCase: mockUseCase
    ))
}


