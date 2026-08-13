//
//  ItemNoteView.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 13/8/26.
//

import SwiftUI

struct ItemNoteView: View {
    @Binding var note: String?
    @State private var isExpanded: Bool
    @FocusState private var isFocused: Bool

    init(note: Binding<String?>) {
        self._note = note
        self._isExpanded = State(initialValue: !(note.wrappedValue ?? "").isEmpty)
    }

    private var hasNote: Bool {
        !(note ?? "").isEmpty
    }

    private var textBinding: Binding<String> {
        Binding(
            get: { note ?? "" },
            set: { note = $0.isEmpty ? nil : $0 }
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Divider()

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
                if isExpanded {
                    isFocused = true
                }
            } label: {
                Label(
                    hasNote ? "Editar nota" : "Añadir nota",
                    systemImage: hasNote ? "note.text" : "note.text.badge.plus"
                )
                .font(.mSemi)
                .foregroundStyle(Color(.prim))
            }

            if isExpanded {
                TextEditor(text: textBinding)
                    .focused($isFocused)
                    .frame(minHeight: 80, maxHeight: 140)
                    .scrollContentBackground(.hidden)
                    .padding(8)
                    .background(Color(.sec).opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    ItemNoteView(note: .constant("El paciente mostró inestabilidad al final del ejercicio."))
        .padding()
}
