//
//  RestaurantAnnotation.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/20/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit
import MapKit

class RestaurantsAnnotations: MKPointAnnotation {
    
    var restaurant: Restaurant!
    
    init(restaurant: Restaurant) {
        super.init()
        
        self.restaurant = restaurant
        self.title = restaurant.name
        self.subtitle = restaurant.description
        self.coordinate = CLLocationCoordinate2D(location: restaurant.address.location)
    }
    
    
}
