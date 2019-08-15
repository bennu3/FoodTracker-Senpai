//
//  Address.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import Foundation
import CoreLocation

struct Address: Codable {
    
    var name: String
    var city: String
    var country: String
    var location: Location
    
    enum CodingKeys: String, CodingKey {
        case name
        case city
        case country
        case latitude
        case longitude
    }
    
    init(name: String, city: String, country: String, location: Location) {
        self.name = name
        self.city = city
        self.country = country
        self.location = location
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        city = try values.decode(String.self, forKey: .city)
        country = try values.decode(String.self, forKey: .country)
        
        let lat = try values.decode(Double.self, forKey: .latitude)
        let lng = try values.decode(Double.self, forKey: .longitude)
        
        location = (lat, lng)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(city, forKey: .city)
        try container.encode(country, forKey: .country)
        
        try container.encode(location.latidude, forKey: .latitude)
        try container.encode(location.longitude, forKey: .longitude)
    }
    
    var cityCountry: String {
        return "\(city), \(country)"
    }
    
    init?(placemark: CLPlacemark) {
        guard let name = placemark.name else {
            return nil
        }
        
        guard let city = placemark.locality else {
            return nil
        }
        
        guard let country = placemark.country else {
            return nil
        }
        
        guard let location = placemark.location else {
            return nil
        }
        
        self.name = name
        self.city = city
        self.country = country
        self.location = (location.coordinate.latitude, location.coordinate.longitude)
    }
    
}
