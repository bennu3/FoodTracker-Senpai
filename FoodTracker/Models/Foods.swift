//
//  Foods.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation

struct Foods: Equatable {
    
    var name: String
    var imageURL: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case imageURL = "image_url"
        case title
    }
    
    init(name: String, restaurant: Restaurant, type: String) {
        self.name = name
        self.imageURL = ""
        self.type = type
    }
}

extension Foods {
    init(managedObject: ManagedRestaurant) {
        self.name = managedObject.name
        self.imageURL = managedObject.imageURL
        self.type = managedObject.foodType
    }
    
    func fill(managedObject: ManagedRestaurant) {
        managedObject.name = self.name
        managedObject.imageURL = self.imageURL
    }
    
}
