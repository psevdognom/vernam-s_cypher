//
//  ContentView.swift
//  Vernam's_cypher
//
//  Main SwiftUI view with TabView navigation
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CypherActionView()
                .tabItem {
                    Label("Шифр", systemImage: "lock.fill")
                }
            
            CypherListView()
                .tabItem {
                    Label("Блокноты", systemImage: "list.bullet")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    ContentView()
}
