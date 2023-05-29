//
//  FavoriteWord+CoreDataProperties.swift
//  Werdd
//
//  Created by Hannie Kim on 5/22/23.
//
//

import Foundation
import CoreData


extension FavoriteWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteWord> {
        return NSFetchRequest<FavoriteWord>(entityName: "FavoriteWord")
    }

    @NSManaged public var definition: String
    @NSManaged public var antonyms: [String]?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var title: String?
    @NSManaged public var examples: [String]?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var partOfSpeech: String?

}

extension FavoriteWord : Identifiable {

}

