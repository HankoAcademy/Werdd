//
//  WordDetail.swift
//  Werdd
//
//  Created by Hannie Kim on 5/29/23.
//

import Foundation

struct WordDetail: Decodable {
    let definition: String
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
    let partOfSpeech: String?
}
