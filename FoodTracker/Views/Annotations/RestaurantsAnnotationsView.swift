//
//  RestaurantsAnnotations.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/20/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotationView: MKAnnotationView {
    
    private let viewFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = viewFrame
        
        let imageView = UIImageView(frame: viewFrame)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = viewFrame.height/2
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        
        guard let restaurantAnnotation = annotation as? RestaurantsAnnotations, let restaurant = restaurantAnnotation.restaurant else {
            return
        }
        imageView.image = UIImage(imageLiteralResourceName: "ftPin")
//        imageView.load(fromURL: restaurant.imageURL) {
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        }, completion: nil)
    }
    
    func deselect() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
}
