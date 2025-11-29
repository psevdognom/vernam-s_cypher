//
//  CypherListView.swift
//  Vernam's_cypher
//
//  SwiftUI view displaying list of cipher keys
//

import SwiftUI

struct CypherListView: View {
    @State private var cypherKeys: [String] = []
    
    var body: some View {
        NavigationStack {
            List(cypherKeys.indices, id: \.self) { index in
                NavigationLink(destination: CypherDetailView(cypherText: cypherKeys[index], keyNumber: index + 1)) {
                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundStyle(.blue)
                        Text("Блокнот номер \(index + 1)")
                    }
                }
            }
            .navigationTitle("Шифроблокноты")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: loadKeys) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .onAppear {
            loadKeys()
        }
    }
    
    private func loadKeys() {
        cypherKeys = CypherLogic.loadCypherKeys()
    }
}

#Preview {
    CypherListView()
}
