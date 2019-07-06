//
//  MobilesCoreDataStore.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 2/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

import Foundation

import CoreData

class MobilesCoreDataStore: MobilesStoreProtocol
{
  
  // MARK: - Managed object contexts
  
  var mainManagedObjectContext: NSManagedObjectContext
  var privateManagedObjectContext: NSManagedObjectContext
  
  // MARK: - Object lifecycle
  
  init()
  {
    // This resource is the same name as your xcdatamodeld contained in your project.
    guard let modelURL = Bundle.main.url(forResource: "MPBG", withExtension: "momd") else {
      fatalError("Error loading model from bundle")
    }
    
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Error initializing mom from: \(modelURL)")
    }
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    mainManagedObjectContext.persistentStoreCoordinator = psc
    
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let docURL = urls[urls.endIndex-1]
    /* The directory the application uses to store the Core Data store file.
     This code uses a file named "DataModel.sqlite" in the application's documents directory.
     */
    let storeURL = docURL.appendingPathComponent("MPBG.sqlite")
    do {
      try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    } catch {
      fatalError("Error migrating store: \(error)")
    }
    
    privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateManagedObjectContext.parent = mainManagedObjectContext
  }
  
  deinit
  {
    do {
      try mainManagedObjectContext.save()
    } catch {
      fatalError("Error deinitializing main managed object context")
    }
  }
  
  func fetchFavouriteMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  {
    privateManagedObjectContext.perform {
      do {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMobile")
        let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [FavouriteMobile]
        let mobiles = results.map { $0.toMobile() }
        completionHandler(mobiles, nil)
      } catch {
        completionHandler(nil, DataError.cannotFetch("Cannot fetch favourite mobile."))
      }
    }
  }
  
  func addFavouriteMobile(mobile: Mobile, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  {
    privateManagedObjectContext.perform { [weak self] in
      guard let self = self else { return }
      do {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMobile")
        fetchRequest.predicate = NSPredicate(format: "id == %d", mobile.id)
        let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [FavouriteMobile]
        guard results.count == 0 else {
          completionHandler(nil, DataError.cannotAdd("Cannot add mobile. This id is exist."))
          return
        }
        
        let favouriteMobile = NSEntityDescription.insertNewObject(forEntityName: "FavouriteMobile", into: self.privateManagedObjectContext) as! FavouriteMobile
        favouriteMobile.fromMobile(mobile: mobile)
        try self.privateManagedObjectContext.save()
        try self.mainManagedObjectContext.save()
          completionHandler(mobile, nil)
      } catch {
        completionHandler(nil, DataError.cannotAdd("Cannot add mobile with id \(String(describing: mobile.id))"))
      }
    }
  }
  
  func deleteFavouriteMobile(id: Int, completionHandler: @escaping (Mobile?, DataError?) -> Void)
  {
    privateManagedObjectContext.perform {
      do {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMobile")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [FavouriteMobile]
        if let managedOrder = results.first {
          let mobile = managedOrder.toMobile()
          self.privateManagedObjectContext.delete(managedOrder)
          do {
            try self.privateManagedObjectContext.save()
            try self.mainManagedObjectContext.save()
            completionHandler(mobile, nil)
          } catch {
            completionHandler(nil, DataError.cannotDelete("Cannot delete mobile with id \(id)"))
          }
        } else {
          throw DataError.cannotDelete("Cannot fetch mobile with id \(id) to delete")
        }
      } catch {
        completionHandler(nil, DataError.cannotDelete("Cannot fetch mobile with id \(id) to delete"))
      }
    }
  }
  
  func fetchMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
  {
    
  }
  
  func fetchMobileImages(id: Int, completionHandler: @escaping ([MobileImage]?, DataError?) -> Void)
  {
    
  }
  
}
