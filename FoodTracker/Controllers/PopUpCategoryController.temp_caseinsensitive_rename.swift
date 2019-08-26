//
//  FavoriteTypeFoodController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/21/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class PopUpCategoryController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let category = Foods.all

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension FavoriteTypeFoodController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryFoodsCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteTypeCell.identifier, for: indexPath) as! FavoriteTypeCell
        categoryFoodsCell.food = category
        return categoryFoodsCell
    }
    
}

extension FavoriteTypeFoodController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at index path: \(indexPath)")
    }
    
}
