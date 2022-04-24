//
//  Word.swift
//  Werdd
//
//  Created by Han Kim on 2/12/22.
//

import Foundation

struct Word: Codable {
    let word: String?
    let results: [WordDetail]?
}

struct WordDetail: Codable {
    let definition: String?
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
    let partOfSpeech: String?
}
