//
//  Category.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/23/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation
import UIKit

struct Category {
    
    var name: String
    var imageURL: String
    
    static func all() -> [Category] {
        let categoryList = [Category(name: "pizza",
                                     imageURL: "pizza"),
                            Category(name: "hamburguesa",
                                     imageURL: "hamburguesa"),
                            Category(name: "helado",
                                     imageURL: "helado"),
                            Category(name: "sopa",
                                     imageURL: "sopa"),
                            Category(name: "pasta",
                                     imageURL: "pasta")
        ]
        return categoryList
    }
    
}
