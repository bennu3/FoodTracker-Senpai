//
//  ProfileController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/14/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var atSubTitleLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var restaurantButton: UIButton!
    @IBOutlet weak var restaurantButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    private var foods: [Foods] = []
//    private var restaurants: [Restaurant] = []
    
    var foodName: String?
    var foodImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    func setupViews() {
        
        imageView.layer.cornerRadius = imageViewHeightConstraint.constant/2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        commentImageView.layer.cornerRadius = commentImageViewHeightConstraint.constant/2
        commentImageView.layer.borderWidth = 1
        commentImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        searchButton.layer.cornerRadius = searchButtonHeightConstraint.constant/6
        restaurantButton.layer.cornerRadius = restaurantButtonHeightConstraint.constant/6
        uploadButton.layer.cornerRadius = uploadButtonHeightConstraint.constant/6
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
    @IBAction func restaurantButton(_ sender: UIButton) {
    }
    @IBAction func uploadButton(_ sender: UIButton) {
    }
    @IBAction func commentButton(_ sender: UIButton) {
    }
    @IBAction func seeAllButton(_ sender: UIButton) {
    }
    
}


extension ProfileViewController: UICollectionViewDelegate {
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return foods.count
    //    }
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.food = foods[indexPath.row]
        
        return cell
    }
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
