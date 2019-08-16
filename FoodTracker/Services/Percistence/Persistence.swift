//
//  Persistence.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/15/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static var shared = PersistenceManager()
    
    private init() {}
    
    var container: NSPersistentContainer {
        
        let container = NSPersistentContainer(name: "Restaurants")
        container.loadPersistentStores { (storeDescription, error) in
            
            guard error == nil else {
                fatalError("No se encontró data model")
            }
        }
        return container
    }
    
    func createOrUpdate(restaurant: Restaurant) {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedRestaurant")
        request.predicate = NSPredicate(format: "name = %@", restaurant.name)
        
        do {
            guard let managedRestaurants = try context.fetch(request) as? [ManagedRestaurant] else {
                return
            }
            
            if let object = managedRestaurants.first {
                print("Actualizando Restaurant")
                restaurant.fill(managedObject: object)
            } else {
                print("Creando Restaurant")
                let managedObject = NSEntityDescription.insertNewObject(forEntityName: "ManagedRestaurant", into: context) as! ManagedRestaurant
                restaurant.fill(managedObject: managedObject)
            }
            
            do {
                try context.save()
                print("Restaurant \(restaurant.name) guardado!")
            } catch {
                print("Error al guardar restaurant \(error.localizedDescription)")
            }
            
        } catch {
            print("Error fetching restaurants \(error.localizedDescription)")
        }
    }
    
    func delete(withName name: String?) {
        let context = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedRestaurant")
        
        if let name = name {
            request.predicate = NSPredicate(format: "name = %@", name)
        }
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("error deleting restaurant")
        }
    }
    
    func fetchRestaurants(text: String?, completion: @escaping ([Restaurant]) -> ()) {
        let context = container.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedRestaurant")
        if let text = text {
            request.predicate = NSPredicate(format: "name = %@", text)
        }
        do {
            guard let managedRestaurants = try context.fetch(request) as? [ManagedRestaurant] else {
                completion([])
                return
            }
            
            let restaurants = managedRestaurants.map { Restaurant(managedObject: $0) }
            completion(restaurants)
        } catch {
            print("Error fetching restaurants \(error.localizedDescription)")
            completion([])
        }
        
    }
    
}

