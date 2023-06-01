//
//  HomeViewModel.swift
//  Werdd
//
//  Created by Hannie Kim on 5/29/23.
//

import Foundation
import UIKit

final class HomeViewModel {
    
    private let networkManager: NetworkManaging
    private var randomWord: Word?
    private var word: Word?
    
    var wordDetails: [WordDetail]? {
        word?.results
    }
    var selectedWord: String? {
        word?.word
    }
    
    let appTitle: String = "Werdd."
    let appTitleFont: UIFont? = UIFont(name: "Rubik-SemiBold", size: 32)
    let backgroundColor = UIColor(named: "Taupe")
    let favoriteButtonTintColor = UIColor(named: "WerddPink")
    
    var randomWordTitle: String? {
        randomWord?.word
    }
    
    var randomWordPartsOfSpeech: String? {
        randomWord?.results?.first?.partOfSpeech
    }
    
    var randomWordDefinition: String? {
        randomWord?.results?.first?.definition
    }
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }

    func refreshRandomWord() async throws {
        let newRandomWord = try await networkManager.fetchRandomWord()
        self.randomWord = newRandomWord
    }
    
    func fetchWord(_ word: String) async throws {
        let wordDetails = try await networkManager.fetchWordWithDetails(word)
        self.word = wordDetails
    }
}
