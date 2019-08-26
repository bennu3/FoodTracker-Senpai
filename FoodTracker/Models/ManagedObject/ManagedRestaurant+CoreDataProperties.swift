//
//  ManagedRestaurant+CoreDataProperties.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedRestaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedRestaurant> {
        return NSFetchRequest<ManagedRestaurant>(entityName: "ManagedRestaurant")
    }

    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var imageURL: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var foodDescription: String
    @NSManaged public var ranking: Double
    @NSManaged public var name: String

}
