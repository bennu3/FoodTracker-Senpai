//
//  UIImageView.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/25/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(fromURL url: String, completion: @escaping () -> ()) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: imageURL) { (data, response, error) in
            
            guard error == nil else {
                completion()
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion()
                return
            }
            
            guard response.statusCode == 200 else {
                completion()
                return
            }
            
            guard let data = data else {
                completion()
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                completion()
            }
            }.resume()
        
    }
}
