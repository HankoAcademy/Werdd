//
//  DataManager.swift
//  Werdd
//
//  Created by Hannie Kim on 5/21/23.
//

import Foundation
import CoreData
import UIKit

final class DataManager {
    var managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - CREATE
    
    func createFavoriteWord(from title: String, and wordDetails: WordDetail) {
        let favoriteWord = FavoriteWord(context: managedObjectContext)
        favoriteWord.title = title
        favoriteWord.definition = wordDetails.definition
        favoriteWord.synonyms = wordDetails.synonyms
        favoriteWord.antonyms = wordDetails.antonyms
        favoriteWord.examples = wordDetails.examples
        favoriteWord.partOfSpeech = wordDetails.partOfSpeech
        favoriteWord.isFavorited = true

        do {
            try managedObjectContext.save()
        } catch {
            print("Unable to add new word. Failed with error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - READ
    
    func fetchAllFavoriteWords(completion: ([FavoriteWord]?) -> Void) {
        do {
            let favoritedWords = try managedObjectContext.fetch(FavoriteWord.fetchRequest())
            completion(favoritedWords)
        } catch {
            completion(nil)
        }
    }
    
    func fetchFavoriteWord(definition: String, title: String, completion: (FavoriteWord?) -> Void) {
        let fetchRequest = NSFetchRequest<FavoriteWord>(entityName: "FavoriteWord")
        fetchRequest.predicate = NSPredicate(format: "definition == %@ AND title == %@", definition, title)
        
        do {
            let favWord = try managedObjectContext.fetch(fetchRequest)
            completion(favWord.first)
        } catch {
            print("Could not fetch due to error: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    // MARK: - DELETE
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteWord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    func delete(title: String, definition: String) {
        let fetchRequest: NSFetchRequest<FavoriteWord> = FavoriteWord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND definition == %@", title, definition)
        
        do {
            let favWord = try managedObjectContext.fetch(fetchRequest)
            for word in favWord {
                managedObjectContext.delete(word)
            }
        } catch {
            print("Could not delete")
        }
    }
    
    func deleteFavoriteWord(_ favoriteWord: FavoriteWord) {
        managedObjectContext.delete(favoriteWord)
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}
