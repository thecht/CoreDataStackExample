//
//  CDPersistentContainer.swift
//  CoreDataStackExample
//
//  Created by Theodore Hecht on 11/13/20.
//

import Foundation
import CoreData

public class CDPersistentContainer: NSPersistentContainer {
    
    public func saveChanges() {
        
//        mainManagedObjectContext.performAndWait {
//            do {
//                if self.mainManagedObjectContext.hasChanges {
//                    try self.mainManagedObjectContext.save()
//                }
//            } catch {
//                print("Unable to save changes of Main Managed Object Context.")
//                print("\(error), \(error.localizedDescription)")
//            }
//        }
//        
//        privateManagedObjectContext.perform {
//            do {
//                if self.privateManagedObjectContext.hasChanges {
//                    try self.privateManagedObjectContext.save()
//                }
//            } catch {
//                print("Unable to save changes of Private Managed Object Context.")
//                print("\(error), \(error.localizedDescription)")
//            }
//        }
    }
}
