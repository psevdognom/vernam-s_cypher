//
//  CypherDetailView.swift
//  Vernam's_cypher
//
//  SwiftUI view displaying cipher key details
//

import SwiftUI

struct CypherDetailView: View {
    let cypherText: String
    let keyNumber: Int
    @State private var isCopied = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Ключ шифра")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text(cypherText)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack {
                    Text("Длина: \(cypherText.count) символов")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Button(action: copyToClipboard) {
                        Label(isCopied ? "Скопировано" : "Копировать", 
                              systemImage: isCopied ? "checkmark" : "doc.on.doc")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        .navigationTitle("Блокнот №\(keyNumber)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = cypherText
        withAnimation {
            isCopied = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                isCopied = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        CypherDetailView(cypherText: "абвгдеёжзийклмноп", keyNumber: 1)
    }
}
