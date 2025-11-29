//
//  CypherActionView.swift
//  Vernam's_cypher
//
//  SwiftUI view for encoding/decoding text with Vernam cipher
//

import SwiftUI

struct CypherActionView: View {
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    @State private var selectedKeyIndex: Int = 0
    @State private var cypherKeys: [String] = []
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Key Selector
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Выбор ключа")
                            .font(.headline)
                        
                        Picker("Блокнот", selection: $selectedKeyIndex) {
                            ForEach(cypherKeys.indices, id: \.self) { index in
                                Text("Блокнот №\(index + 1)").tag(index)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    // Input Text Area
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Введите текст")
                            .font(.headline)
                        
                        TextEditor(text: $inputText)
                            .font(.system(.body, design: .monospaced))
                            .frame(minHeight: 120)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .focused($isInputFocused)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(isInputFocused ? Color.blue : Color.clear, lineWidth: 2)
                            )
                    }
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button(action: encodeText) {
                            Label("Зашифровать", systemImage: "lock.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        
                        Button(action: decodeText) {
                            Label("Расшифровать", systemImage: "lock.open.fill")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                    
                    // Output Text Area
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Результат")
                                .font(.headline)
                            
                            Spacer()
                            
                            if !outputText.isEmpty {
                                Button(action: copyOutput) {
                                    Image(systemName: "doc.on.doc")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        
                        Text(outputText.isEmpty ? "Результат появится здесь..." : outputText)
                            .font(.system(.body, design: .monospaced))
                            .foregroundStyle(outputText.isEmpty ? .secondary : .primary)
                            .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    // Clear Button
                    Button(action: clearAll) {
                        Label("Очистить", systemImage: "trash")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                .padding()
            }
            .navigationTitle("Шифр Вернама")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Готово") {
                        isInputFocused = false
                    }
                }
            }
            .alert("Внимание", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
        .onAppear {
            loadKeys()
        }
    }
    
    private func loadKeys() {
        cypherKeys = CypherLogic.loadCypherKeys()
    }
    
    private func encodeText() {
        guard !inputText.isEmpty else {
            alertMessage = "Введите текст для шифрования"
            showingAlert = true
            return
        }
        
        guard selectedKeyIndex < cypherKeys.count else {
            alertMessage = "Ключ не найден"
            showingAlert = true
            return
        }
        
        let key = cypherKeys[selectedKeyIndex]
        // Remove the leading number from key if present
        let cleanKey = String(key.dropFirst())
        
        outputText = CypherLogic.encodeString(original: inputText, cypher: cleanKey)
    }
    
    private func decodeText() {
        guard !inputText.isEmpty else {
            alertMessage = "Введите текст для расшифровки"
            showingAlert = true
            return
        }
        
        guard selectedKeyIndex < cypherKeys.count else {
            alertMessage = "Ключ не найден"
            showingAlert = true
            return
        }
        
        let key = cypherKeys[selectedKeyIndex]
        // Remove the leading number from key if present
        let cleanKey = String(key.dropFirst())
        
        outputText = CypherLogic.decodeString(encoded: inputText, cypher: cleanKey)
    }
    
    private func copyOutput() {
        UIPasteboard.general.string = outputText
    }
    
    private func clearAll() {
        inputText = ""
        outputText = ""
    }
}

#Preview {
    CypherActionView()
}
