//
//  Database.swift
//  FavouriteArticles
//
//  Created by Leke Abolade on 06/04/2018.
//  Copyright © 2018 Leke Abolade. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Database {
    
    static var loadHeadlines: [Headline] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Headline")
        
        do {
            let headlines = try managedContext.fetch(fetchRequest) as! [Headline]
            return headlines
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    static var loadFavouritedHeadlines: [Headline] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Headline")
        
        let favouritePredicate = NSPredicate(format: "favourite == %@", true as CVarArg)
        fetchRequest.predicate = favouritePredicate
        
        do {
            let favouriteHeadlines = try managedContext.fetch(fetchRequest) as! [Headline]
            return favouriteHeadlines
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return []
    }
}
