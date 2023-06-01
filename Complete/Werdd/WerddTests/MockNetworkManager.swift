//
//  MockNetworkManager.swift
//  WerddTests
//
//  Created by Hannie Kim on 5/30/23.
//

import Foundation
@testable import Werdd

class MockNetworkManager: NetworkManaging {
    
    var _fetchRandomWord: Word?
    func fetchRandomWord() async throws -> Word {
        guard let randomWord = _fetchRandomWord else {
            throw APIError.decodingError
        }
        
        return randomWord
    }
    
    func fetchWordWithDetails(_ word: String) async throws -> Word {
        return Word(word: "Happy", results: nil)
    }
}
