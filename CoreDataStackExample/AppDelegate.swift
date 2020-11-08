//
//  AppDelegate.swift
//  CoreDataStackExample
//
//  Created by Theodore Hecht on 11/2/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let coreDataManager = CoreDataManager(modelName: "DataModel")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(coreDataManager.mainManagedObjectContext)
        
        return true
    }


}

