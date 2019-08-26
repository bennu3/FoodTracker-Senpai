//
//  Address.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/25/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation
import CoreLocation

struct Address: Codable {

    var location: Location
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(location: Location) {

        self.location = location
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let lat = try values.decode(Double.self, forKey: .latitude)
        let lng = try values.decode(Double.self, forKey: .longitude)
        
        location = (lat, lng)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(location.latidude, forKey: .latitude)
        try container.encode(location.longitude, forKey: .longitude)
    }
    
    init?(placemark: CLPlacemark) {
        
        guard let location = placemark.location else {
            return nil
        }
        
        self.location = (location.coordinate.latitude, location.coordinate.longitude)
    }
    
}
