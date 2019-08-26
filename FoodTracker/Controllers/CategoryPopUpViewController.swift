//
//  CategoryPopUpViewController.swift
//  FoodTracker
//
//  Created by Diego Garcia on 8/23/19.
//  Copyright © 2019 Diego Garcia. All rights reserved.
//

import UIKit

class CategoryPopUpViewController: UIViewController {

    // IBOulets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    // Variables
    private let categoryData = Category.all()
    private let itemsPerRow = 4
    private let minimumInteritemSpacing: CGFloat = 5
    private let minimumInterlineSpacing: CGFloat = 5
    private let sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private var itemSize: CGSize {
        let spacing = UIScreen.main.bounds.width - sectionInset.left - sectionInset.right - (minimumInteritemSpacing * CGFloat(itemsPerRow - 1))
        let itemSize = floor(spacing/CGFloat(itemsPerRow))
        return CGSize(width: itemSize, height: itemSize)
    }
    
    var categorySelectedIndex = [IndexPath]()
    var categorySelectedData = [String]()
    
    var categoryIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let categoryIndexPath = categoryIndexPath {
                indexPaths.append(categoryIndexPath)
            }
            
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: indexPaths)
            }) { _ in
                if let categoryIndexPath = self.categoryIndexPath {
                    self.collectionView.scrollToItem(at: categoryIndexPath,
                                                     at: .centeredVertically,
                                                     animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setup()
    }
    
    private func setup() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumInterlineSpacing
        layout.sectionInset = sectionInset
        collectionView.layer.cornerRadius = 10
        
        nextButton.layer.cornerRadius = 10
        nextButton.layer.shadowColor = UIColor.gray.cgColor
        nextButton.layer.shadowOpacity = 0.8
        nextButton.layer.shadowOffset = CGSize.zero
        nextButton.layer.shadowRadius = 5
        nextButton.layer.backgroundColor = UIColor.red.cgColor
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: .saveSelectedCategory, object: self)
        print(categorySelectedData)
        
    }
}

extension CategoryPopUpViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.category = categoryData[indexPath.row]
        
        if categorySelectedIndex.contains(indexPath) {
            cell.backgroundColor = UIColor.red
        }
        else {
            cell.backgroundColor = UIColor.white
        }
        
        cell.layoutSubviews()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
}

extension CategoryPopUpViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        
        let strData = categoryData[indexPath.item]
        
        if categorySelectedIndex.contains(indexPath) {
            categorySelectedIndex = categorySelectedIndex.filter { $0 != indexPath}
            categorySelectedData = categorySelectedData.filter { $0 != strData.name}
        }
        else {
            categorySelectedIndex.append(indexPath)
            categorySelectedData.append(strData.name)
        }
        
        collectionView.reloadData()
    }
}
