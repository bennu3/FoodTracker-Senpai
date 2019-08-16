//
//  Restaurant.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation

struct Restaurant: Codable, Equatable {
    
    var name: String
    var imageURL: String
    var address: Address
    var ranking: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case address
        case ranking
    }
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
        self.imageURL = ""
        self.ranking = 0.0
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name
    }
    
}

extension Restaurant {
    
    init(managedObject: ManagedRestaurant) {
        self.name = managedObject.name
        self.imageURL = managedObject.imageURL
        self.ranking = managedObject.ranking
        
        self.address = Address(name: managedObject.address, city: managedObject.city, country: managedObject.country, location: (managedObject.latitude, managedObject.longitude))
    }
    
    func fill(managedObject: ManagedRestaurant) {
        managedObject.name = self.name
        managedObject.address = self.address.name
        managedObject.imageURL = self.imageURL
        managedObject.city = self.address.city
        managedObject.country = self.address.country
        managedObject.latitude = self.address.location.latidude
        managedObject.longitude = self.address.location.longitude
        managedObject.ranking = self.ranking
    }
    
}
