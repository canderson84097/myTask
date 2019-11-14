//
//  CoreDataStack.swift
//  Task
//
//  Created by Chris Anderson on 11/13/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {

 static let container: NSPersistentContainer = {

     let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
     let container = NSPersistentContainer(name: appName)
     container.loadPersistentStores() { (storeDescription, error) in
         if let error = error as NSError? {
             fatalError("Unresolved error \(error), \(error.userInfo)")
         }
     }
     return container
 }()

 static var context: NSManagedObjectContext { return container.viewContext }
}
