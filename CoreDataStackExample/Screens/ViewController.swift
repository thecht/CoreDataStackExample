//
//  ViewController.swift
//  CoreDataStackExample
//
//  Created by Theodore Hecht on 11/2/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
        
    var dataManager: CoreDataManager!
    
    var deleteButton: CDButton = {
        let btn = CDButton(backgroundColor: .systemRed, title: "Delete")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(deleteStores), for: .touchUpInside)
        return btn
    }()
    var addButton1: CDButton = {
        let btn = CDButton(backgroundColor: .systemBlue, title: "Add Data")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addData), for: .touchUpInside)
        return btn
    }()
    var addButton2: CDButton = {
        let btn = CDButton(backgroundColor: .systemGreen, title: "Add Background Data")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addBGData), for: .touchUpInside)
        return btn
    }()
    var printViewStoreButton: CDButton = {
        let btn = CDButton(backgroundColor: .systemPurple, title: "Print")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(printData), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupButtons()
        let container = dataManager.container
        print("ViewContextParent: \(String(describing: container.viewContext.parent))")
        
        let backgroundContext = container.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.undoManager = nil
        
        print("BackgroundParent: \(backgroundContext.parent)")
        
    }
    
    private func setupButtons() {
        let padding: CGFloat = 20
        
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding*2)
        ])
        
        view.addSubview(addButton1)
        NSLayoutConstraint.activate([
            addButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addButton1.heightAnchor.constraint(equalToConstant: 50),
            addButton1.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: padding)
        ])
        
        view.addSubview(addButton2)
        NSLayoutConstraint.activate([
            addButton2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addButton2.heightAnchor.constraint(equalToConstant: 50),
            addButton2.topAnchor.constraint(equalTo: addButton1.bottomAnchor, constant: padding)
        ])
        
        view.addSubview(printViewStoreButton)
        NSLayoutConstraint.activate([
            printViewStoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            printViewStoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            printViewStoreButton.heightAnchor.constraint(equalToConstant: 50),
            printViewStoreButton.topAnchor.constraint(equalTo: addButton2.bottomAnchor, constant: padding)
        ])

    }
    
    @objc private func addData() {
        let context = dataManager.container.viewContext
        
        let data = MyDataObject(context: context)
        data.date = Date()
        data.title = "First"
        data.subtitle = "fff"
        
        let data2 = MyDataObject(context: context)
        data2.date = Date()
        data2.title = "Second"
        data2.subtitle = "sss"
        
        try? context.save()
        
        print("DATA ADDED")
    }
    
    @objc private func addBGData() {
        let bgContext = dataManager.container.newBackgroundContext()
        bgContext.perform { [weak self] in
            guard let self = self else { return }
            
            for i in (1...3) {
                let data = MyDataObject(context: bgContext)
                data.date = Date()
                data.title = "\(i)"
                data.subtitle = "\(i)"
            }
            
            try? bgContext.save()
            
            self.dataFetchCompleted()
        }
    }
    
    @objc private func deleteStores() {
        let context = dataManager.container.viewContext
        let fetchRequest = NSFetchRequest<MyDataObject>(entityName: "MyDataObject")
        var numberOfDeletedRecords = 0
        
        if let fetchedData = try? context.fetch(fetchRequest) {
            numberOfDeletedRecords = fetchedData.count
            for data in fetchedData {
                context.delete(data)
            }
        }
        
        do {
            try context.save()
            print("DELETED \(numberOfDeletedRecords) RECORDS.")
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    @objc private func sync() {
        print("SYNC PRESSED")
    }
    
    @objc private func printData() {
        let context = dataManager.container.viewContext
        let fetchRequest: NSFetchRequest<MyDataObject> = MyDataObject.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        if let fetchedData = try? context.fetch(fetchRequest) {
            print("----")
            print("Fetched \(fetchedData.count) objects:")
            for data in fetchedData {
                print(data.description)
            }
        }
        
    }

    func dataFetchCompleted() {
        print("Data Fetch Completed")
        printData()
    }

}

