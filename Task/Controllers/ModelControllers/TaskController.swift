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
    
    var tasks: [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return (try? CoreDataStack.context.fetch(request)) ?? []
        }
    }
    
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
