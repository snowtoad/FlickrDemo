//
//  PresistenceManager.swift
//  FlickrDemo
//
//  Created by apple on 2020/5/27.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
    private init() {}
    static let shared = PersistenceManager()
    
    //MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FlickrDemo")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    //MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(error), \(nserror.userInfo)")
            }
        }
    }
    
    func getFavoriteInfo(predicate: NSPredicate? = nil) -> [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            return try self.context.fetch(request)
        } catch {
            print("Favorite Error")
            return [Favorite]()
        }
        
    }
    
    func insertFavoriteInfo(_ flickrPhoto: FlickrPhoto) {
        let predicate = NSPredicate.init(format: "id = %@", flickrPhoto.id)
        let favorites = self.getFavoriteInfo(predicate: predicate)
        do {
            var favorite: Favorite
            
            if favorites.isEmpty {
                favorite = Favorite(context: self.context)
                
                favorite.id = flickrPhoto.id
                favorite.farm = Int64(flickrPhoto.farm)
                favorite.isfamily = Int64(flickrPhoto.isfamily)
                favorite.ispublic = Int64(flickrPhoto.ispublic)
                favorite.owner = flickrPhoto.owner
                favorite.secret = flickrPhoto.secret
                favorite.server = flickrPhoto.server
                favorite.title = flickrPhoto.title
            }
            
            try self.context.save()
            print("Insert FavoriteInfo Successfully")
        } catch {
            print("Insert FavoriteInfo Error")
        }
    }
    
    func deleteFavoriteInfo(_ favorite: Favorite) {
        let predicate = NSPredicate.init(format: "id = %@", favorite.id!)
        let favorites = self.getFavoriteInfo(predicate: predicate)
        
        if favorites.count > 0 {
            context.delete(favorite)
        }
        
        do {
            try self.context.save()
            print("Delete FavoriteInfo Successfully")
        } catch {
            print("Delete FavoriteInfo Error")
        }
    }
    
    func deleteFlickrPhoto(predicate: NSPredicate? = nil, flickrPhoto: FlickrPhoto) {
        let predicate = NSPredicate.init(format: "id = %@", flickrPhoto.id)
        let favorites = self.getFavoriteInfo(predicate: predicate)
        
        if favorites.count > 0 {
            context.delete(favorites.first!)
        }
        
        do {
            try self.context.save()
            print("Delete FlickrPhoto Successfully")
        } catch {
            print("Delete FlickrPhoto Error")
        }
    }
    
    func checkIsFavorite(_ flickrPhoto: FlickrPhoto, completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate.init(format: "id = %@", flickrPhoto.id)
        let favorites = self.getFavoriteInfo(predicate: predicate)
        if favorites.count > 0 {
           completion(true)
        } else {
            completion(false)
        }
    }

}
