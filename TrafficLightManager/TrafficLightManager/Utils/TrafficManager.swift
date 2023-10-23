//
//  TrafficManager.swift
//  TrafficLightManager
//
//  Created by Naveed on 23/10/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    // Singleton instance
    static let shared = CoreDataManager()
    
    // The persistent container for the Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrafficLightManager") // Replace with your model name
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    // The managed object context
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Prevent external instantiation
    private init() { }
    
    // Save changes to the Core Data stack
    func saveContext() {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    // Insert a new DataEntity
    func insertDataEntity(timestamp: Date, text: String) {
        let entity = NSEntityDescription.entity(forEntityName: "LightState", in: managedObjectContext)
        let dataEntity = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        dataEntity.setValue(timestamp, forKey: "stateTime")
        dataEntity.setValue(text, forKey: "name")
        
        saveContext()
    }
    
    // Fetch DataEntity objects
    func fetchDataEntities() -> [LightState] {
        let fetchRequest: NSFetchRequest<LightState> = LightState.fetchRequest()
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
}
