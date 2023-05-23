//
//  Word.swift
//  Werdd
//
//  Created by Han Kim on 2/12/22.
//

import Foundation

struct Word: Decodable {
    let word: String
    let results: [WordDetail]?
}

struct WordDetail: Decodable {
    let definition: String
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
    let partOfSpeech: String?
}
