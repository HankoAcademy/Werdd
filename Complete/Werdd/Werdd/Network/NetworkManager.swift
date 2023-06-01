//
//  NetworkManager.swift
//  Werdd
//
//  Created by Hannie Kim on 4/18/22.
//

import Foundation

enum APIError: LocalizedError {
    case networkError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Unable to return data from network request", comment: "API returned an error")
        case .decodingError:
            return NSLocalizedString("Unable to decode", comment: "Review data models and the JSON they're trying to decode")
        }
    }
}

protocol NetworkManaging {
    func fetchRandomWord() async throws -> Word
    func fetchWordWithDetails(_ word: String) async throws -> Word
}

final class NetworkManager: NetworkManaging {
    
    /// Makes a network request for a randomly generated word and its details
    func fetchRandomWord() async throws -> Word {
        guard let randomWordDataURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions") else {
            throw CommonError.invalidURL
        }
        
        let headers = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: randomWordDataURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let randomWord = try JSONDecoder().decode(Word.self, from: data)
            return randomWord
        } catch {
            print("Fetching for random word failed with error: \(error.localizedDescription)")
            throw APIError.networkError
        }
    }
    
    /// Fetches details for a specified word
    /// - Parameter word: The word in which we want additional details for
    func fetchWordWithDetails(_ word: String) async throws -> Word {
        guard let fetchWordDataURL = URL(string: "https://worsdapiv1.p.rapidapi.com/words/\(word)") else {
            throw CommonError.invalidURL
        }
        
        let headers = [
            "x-rapidapi-key": APIConstants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: fetchWordDataURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let word = try JSONDecoder().decode(Word.self, from: data)
            return word
        } catch {
            print("Failed to decode Word with error: \(error.localizedDescription)")
            throw error
        }
    }
}
