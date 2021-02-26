//
//  SearchBarView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    @State private var showCancel: Bool = false
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                textFieldBar

                if showCancel {
                    Button("Cancel") {
                        cancelAction()
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    private var textFieldBar: some View {
        HStack {
            Image(symbol: .magnifyingGlass)
                .font(.body)
                .foregroundColor(.secondary)
            
            TextField(
                "Search",
                text: $text,
                onEditingChanged: { isUserEditing in
                    withAnimation {
                        showCancel = isUserEditing
                    }
                },
                onCommit: { })

            if !text.isEmpty {
                clearTextButton
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }

    private var clearTextButton: some View {
        Button(
            action: {
                clearTextAction()
            },
            label: {
                Image(symbol: .xmarkCircleFill)
                    .font(.body)
                    .foregroundColor(.secondary)
            })
            .buttonStyle(PlainButtonStyle())
    }

    private func clearTextAction() {
        text = ""
    }

    private func cancelAction() {
        clearTextAction()
        // Resign first responder
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
