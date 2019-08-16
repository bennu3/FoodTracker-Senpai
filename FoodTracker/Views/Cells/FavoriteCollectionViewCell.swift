//
//  FavoriteCollectionViewCell.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var typeFoodLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    var food: Foods! {
        didSet {
            titleLabel.text = "\(food.name)"
            typeFoodLabel.text = food.type
            
//            imageViewCell.image = food.imageURL
//                {
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                }
//            }
        }
    }
    
    var restaurants: Restaurant! {
        didSet {
            restaurantLabel.text = restaurants.name
            rankingLabel.text = String(restaurants.ranking)
//            startImageView?.load(fromURL: restaurants.imageURL) {
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                }
//            }
        }
    }
    
}

