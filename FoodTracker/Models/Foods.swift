//
//  Foods.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation

struct Foods {
    
    var name: String
    var description: String
    var imageURL: String
    
    static var all: Foods {
        let favoritesFoods =
            Foods(name: "pizzar",
                   description: "napolitana",
                   imageURL: "pizza")
        return favoritesFoods
    }
}
