//
//  CoreDataManager.swift
//  CoreDataStackExample
//
//  Created by Theodore Hecht on 11/17/20.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private var dataModelName = "model"
    
    init(dataModelName: String) {
        self.dataModelName = dataModelName
    }
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataModelName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unresolved error when loading persistent stores: \(error), \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    public func saveChanges() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                let nserror = error  as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
