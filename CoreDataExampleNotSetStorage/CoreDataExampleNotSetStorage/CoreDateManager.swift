//
//  CoreDateManager.swift
//  CoreDataExampleNotSetStorage
//
//  Created by Jungjin Park on 2024-07-02.
//

import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        // in memory, so it will be reset when it is restart
        persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    func savePet(name: String, breed: String) {
        let pet = Animal(context: persistentContainer.viewContext)
        pet.name = name
        pet.breed = breed
        do {
            try persistentContainer.viewContext.save()
            print("Pet saved!")


        } catch {
            print("Failed to save pet \(error)")
        }
    }

    func getAllPets() -> [Animal] {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func deletePet(animal: Animal) {
        persistentContainer.viewContext.delete(animal)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
