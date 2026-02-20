//
//  PatientTestDetailView.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 18/2/26.
//

import SwiftUI

struct TestDetailView: View {
    @State var viewModel: TestDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                testHeader
                Divider()
                testItems
            }
            .padding()
        }
        .background(Color(.backg))
        .navigationTitle(viewModel.test.testType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Header
    
    private var testHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.test.testType.rawValue)
                .font(.lSemi)
                .foregroundStyle(.textPrim)
            
            if let evaluator = viewModel.test.evaluator {
                Text(String(localized: "testDetail.evaluator", defaultValue: "Evaluador: \(evaluator)"))
                    .font(.s)
                    .foregroundStyle(.textPrim)
            }
            
            Text(viewModel.test.date.formatted(date: .abbreviated, time: .omitted))
                .font(.m)
                .foregroundStyle(.textPrim)
            
            Text(String(format: String(localized: "testDetail.totalScore"), viewModel.test.totalScore, viewModel.test.maxScore.map { "/\($0)" } ?? ""))
                .font(.lSemi)
                .foregroundStyle(.textPrim)
            
            Spacer()
            
            Button {
                //exportPDF()
            } label: {
                Label(String(localized: "testDetail.exportPDF"), systemImage: "square.and.arrow.up")
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.prim)
            .foregroundStyle(.textOnPrim)
            .font(.m)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
    }
    
    // MARK: - Items
    
    @ViewBuilder
    private var testItems: some View {
        switch viewModel.test {
        case let berg as BergTest:
            BergDetailSection(test: berg)
        case let motricity as MotricityIndex:
            MotricityDetailSection(test: motricity)
        case let trunk as TrunkControlTest:
            TrunkControlDetailSection(test: trunk)
        default:
            Text(String(localized: "testDetail.unknownTest"))
        }
    }
    
    // MARK: - Item Row
    
    private struct TestItemRow: View {
        let itemNumber: Int
        let title: String
        let description: String
        let scoreText: String
        
        @State private var isExpanded = false
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Text("\(itemNumber)- \(title) :")
                            .font(.m)
                            .foregroundStyle(.textOnPrim)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.s)
                            .foregroundStyle(.textOnPrim)
                    }
                }
                .buttonStyle(.plain)
                
                if isExpanded {
                    Text(description)
                        .font(.s)
                        .foregroundStyle(.textOnPrim)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Text(scoreText)
                    .font(.m)
                    .foregroundStyle(.textOnPrim)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color(.prim))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding()
            .background(Color(.prim))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    // MARK: - Berg Section
    
    private struct BergDetailSection: View {
        let test: BergTest
        
        private var items: [BergItemPDF] {
            let definitions = BergItemCatalog.allDefinitions()
            return test.items.enumerated().compactMap { index, item in
                guard let definition = definitions.first(where: { $0.type == item.itemType }) else { return nil }
                let scoreDescription = definition.scoringOptions.first(where: { $0.score == item.score })?.description ?? "Sin puntuar"
                return BergItemPDF(number: index + 1, definition: definition, item: item, test: test, scoreDescription: scoreDescription)
            }
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(String(localized: "testDetail.items"))
                    .font(.lSemi)
                    .foregroundStyle(.prim)
                
                ForEach(items, id: \.number) { item in
                    TestItemRow(
                        itemNumber: item.number,
                        title: item.title,
                        description: item.description,
                        scoreText: item.scoreDescription
                    )
                }
            }
        }
    }
    
    // MARK: - Motricity Section

    private struct MotricityDetailSection: View {
        let test: MotricityIndex
        
        private var upperItems: [MotricityIndexItemPDF] {
            prepareItems(filter: { $0.itemType.isUpperLimb })
        }
        
        private var lowerItems: [MotricityIndexItemPDF] {
            prepareItems(filter: { $0.itemType.isLowerLimb }, startingAt: upperItems.count + 1)
        }
        
        private func prepareItems(filter: (MotricityIndexItem) -> Bool, startingAt start: Int = 1) -> [MotricityIndexItemPDF] {
            let definitions = MotricityIndexCatalog.definitions
            return test.items.filter(filter).enumerated().compactMap { index, item in
                guard let definition = definitions[item.itemType] else { return nil }
                let scoreDescription = definition.scoringOptions.first(where: {$0.score == item.score})?.description ?? "\(item.score ?? 0)"
                return MotricityIndexItemPDF(number: start + index, definition: definition, item: item, scoreDescription: scoreDescription)
            }
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                if let side = test.side {
                    Text(String(format: String(localized: "testDetail.side"), side.rawValue.capitalized))
                        .font(.mSemi)
                        .foregroundStyle(.secondary)
                }
                
                Text(String(localized: "testDetail.upperLimb"))
                    .font(.mSemi)
                    .foregroundStyle(.prim)
                
                ForEach(upperItems, id: \.number) { item in
                    TestItemRow(
                        itemNumber: item.number,
                        title: item.title,
                        description: item.description,
                        scoreText: item.scoreDescription
                    )
                }
                
                Text(String(localized: "testDetail.lowerLimb"))
                    .font(.mSemi)
                    .foregroundStyle(.prim)
                    .padding(.top, 8)
                
                ForEach(lowerItems, id: \.number) { item in
                    TestItemRow(
                        itemNumber: item.number,
                        title: item.title,
                        description: item.description,
                        scoreText: item.scoreDescription
                    )
                }
            }
        }
    }
    
    // MARK: - Trunk Control Section
    
    private struct TrunkControlDetailSection: View {
        let test: TrunkControlTest
        
        private var items: [TrunkControlItemPDF] {
            let definitions = TrunkControlTestCatalog.definitions
            return test.items.enumerated().compactMap { index, item in
                guard let definition = definitions[item.itemType] else { return nil }
                let scoreDescription = definition.scoringOptions.first(where: {$0.score == item.score})?.description ?? "\(item.score ?? 0)"
                return TrunkControlItemPDF(number: index + 1, definition: definition, item: item, scoreDescription: scoreDescription)
            }
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(String(localized: "testDetail.items"))
                    .font(.lSemi)
                    .foregroundStyle(.prim)
                
                ForEach(items, id: \.number) { item in
                    TestItemRow(
                        itemNumber: item.number,
                        title: item.title,
                        description: item.description,
                        scoreText: item.scoreDescription
                    )
                }
            }
        }
    }
}


#Preview {
    TestDetailView(viewModel: TestDetailViewModel(test: TrunkControlTest.patient1, patient: Patient.patient1))
}
