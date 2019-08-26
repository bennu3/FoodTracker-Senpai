//
//  Restaurants.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/19/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation

struct Restaurant: Codable, Equatable {
    
    var name: String
    var imageURL: String
    var description: String
    var address: Address
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case description
        case address
    }
    
    init(name: String, description: String, address: Address) {
        self.name = name
        self.imageURL = ""
        self.description = description
        self.address = address
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name
    }
    
}

