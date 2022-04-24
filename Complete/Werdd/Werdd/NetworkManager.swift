//
//  NetworkManager.swift
//  Werdd
//
//  Created by Hannie Kim on 4/18/22.
//

import Foundation

enum CommonError: LocalizedError {
    case defaultError
    case invalidURL
    
    var errorDescription: String? {
        switch self {
        case .defaultError:
            return "An error occured"
        case .invalidURL:
            return "Invalid url format"
        }
    }
}

enum APIError: LocalizedError {
    case missingOrInvalidData
    
    var errorDescription: String? {
        switch self {
        case .missingOrInvalidData:
            return "Missing or invalid data"
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchRandomWord(completion: @escaping (Result<Word, Error>) -> Void) {
        guard let randomWordDataURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions") else {
            completion(.failure(APIError.missingOrInvalidData))
            return
        }
        
        let headers = [
            "x-rapidapi-key": "yourapikey",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: randomWordDataURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.missingOrInvalidData))
                print("Fetching for random word failed with error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(randomWord))
            }
            catch {
                print("Failed to decode Word with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchWordWithDetails(_ word: String, completion: @escaping (Result<Word, Error>) -> Void) {
        guard let fetchWordDataURL = URL(string: "https://worsdapiv1.p.rapidapi.com/words/\(word)") else {
            completion(.failure(CommonError.invalidURL))
            return
        }
        
        let headers = [
            "x-rapidapi-key": "yourapikey",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: fetchWordDataURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.missingOrInvalidData))
                return
            }
            
            do {
                let word = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(word))
            }
            catch {
                print("Failed to decode Word with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
