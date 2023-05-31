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
