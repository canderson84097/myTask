//
//  TaskController.swift
//  Task
//
//  Created by Chris Anderson on 11/13/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedInstance = TaskController()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("")
        }
    }
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        let isCompleteSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        fetchRequest.sortDescriptors = [isCompleteSortDescriptor, dueSortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
    }()
    
    func add(name: String, notes: String?, due: Date?) {
        _ = Task(name: name, isComplete: false)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    func delete(task: Task) {
        let moc = CoreDataStack.context
        
        moc.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            print("There was a problem trying to save to persistence: \(error.localizedDescription)")
        }
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
}
