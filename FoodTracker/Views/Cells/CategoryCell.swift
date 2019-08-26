//
//  FavoriteTypeFoodCell.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/21/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var uiView: UIView!
    
    var category: Category? {
        didSet {
            guard let category = category else { return }
            imageView.image = UIImage(named: category.imageURL)
            categoryName.text = category.name
            setup()
        }
    }

    func setup() {
        uiView.backgroundColor = UIColor.white
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.cornerRadius = 10
        uiView.layer.shadowOpacity = 0.5
        uiView.layer.shadowRadius = 4
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.cornerRadius = 10
    }
    
    static let identifier = "CategoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
