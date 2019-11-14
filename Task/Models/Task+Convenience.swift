//
//  Task+Convenience.swift
//  Task
//
//  Created by Chris Anderson on 11/13/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, isComplete: Bool, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
}
