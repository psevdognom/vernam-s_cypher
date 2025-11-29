//
//  CypherLogic.swift
//  Vernam's_cypher
//
//  Vernam cipher encoding/decoding logic
//

import Foundation

struct CypherLogic {
    /// Russian alphabet used for the Vernam cipher
    static let alphabet: [Character] = [
        "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о",
        "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"
    ]
    
    /// Get the index of a character in the alphabet
    static func getLetterIndex(_ letter: Character) -> Int {
        for (index, char) in alphabet.enumerated() {
            if letter == char {
                return index
            }
        }
        return 0
    }
    
    /// Encode a single character using Vernam cipher
    static func encodeLetter(cypherLetter: Character, originalLetter: Character) -> Character {
        let newIndex = (getLetterIndex(cypherLetter) + getLetterIndex(originalLetter)) % 32
        return alphabet[newIndex]
    }
    
    /// Decode a single character using Vernam cipher
    static func decodeLetter(cypherLetter: Character, originalLetter: Character) -> Character {
        let newIndex = abs(getLetterIndex(originalLetter) - getLetterIndex(cypherLetter))
        return alphabet[newIndex]
    }
    
    /// Encode a string using Vernam cipher
    static func encodeString(original: String, cypher: String) -> String {
        var result = ""
        let originalChars = Array(original)
        let cypherChars = Array(cypher)
        
        for (index, originalChar) in originalChars.enumerated() {
            guard index < cypherChars.count else { break }
            let encodedChar = encodeLetter(cypherLetter: cypherChars[index], originalLetter: originalChar)
            result.append(encodedChar)
        }
        return result
    }
    
    /// Decode a string using Vernam cipher
    static func decodeString(encoded: String, cypher: String) -> String {
        var result = ""
        let encodedChars = Array(encoded)
        let cypherChars = Array(cypher)
        
        for (index, encodedChar) in encodedChars.enumerated() {
            guard index < cypherChars.count else { break }
            let decodedChar = decodeLetter(cypherLetter: encodedChar, originalLetter: cypherChars[index])
            result.append(decodedChar)
        }
        return result
    }
    
    /// Load cipher keys from file
    static func loadCypherKeys() -> [String] {
        guard let path = Bundle.main.path(forResource: "cypher", ofType: "txt"),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            return []
        }
        return content.components(separatedBy: "\n").filter { !$0.isEmpty }
    }
    
    /// Get a specific cipher key by index
    static func getCypherKey(at index: Int) -> String? {
        let keys = loadCypherKeys()
        guard index >= 0 && index < keys.count else { return nil }
        return keys[index]
    }
}
