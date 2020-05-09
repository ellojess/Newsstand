//
//  CategoriesViewController.swift
//  Newsstand
//
//  Created by Bo on 4/23/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UIViewController {
    
    let data = ["Business", "Entertainment", "Health", "Science", "Technology", "Sports", "General"]
    let images = ["business", "entertainment", "health", "science", "technology", "sports", "general"]
//    let data: [Category]= [
//        Category(title: "Business", image: UIImage(named: "business")!),
//        Category(title: "Entertainment", image: UIImage(named: "entertainment")!),
//        Category(title: "Health", image: UIImage(named: "health")!),
//        Category(title: "Science", image: UIImage(named: "science")!),
//        Category(title: "Technology", image: UIImage(named: "technology")!),
//        Category(title: "Sports", image: UIImage(named: "sports")!),
//        Category(title: "General", image: UIImage(named: "general")!)
//    ]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews(){
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(collectionView)
        collectionView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.heightAnchor, multiplier: 1.0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
}



extension CategoriesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spaceBetweenCell :CGFloat = 0
        let screenWidth = UIScreen.main.bounds.size.width - CGFloat(2 * spaceBetweenCell)
        let totalSpace = spaceBetweenCell * 1.0
        
        if indexPath.row == data.count-1 { // change view for last cell if odd number of cells
            
            if data.count % 2  == 1 { // check if last cell is odd
                return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height-totalSpace)/4) // all Width and same previous height
            } else {
                return CGSize(width: (collectionView.frame.width-totalSpace)/2.2, height: (collectionView.frame.height-totalSpace)/3)
            }
        } else {
            return CGSize(width: (collectionView.frame.width-totalSpace)/2.2, height: (collectionView.frame.height-totalSpace)/3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.backgroundColor = .green
        cell.title.text = data[indexPath.row]
        cell.categoryImage.image = UIImage(named: "\(images[indexPath.row])")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item in row \(indexPath.row)")
        
        let chosenCategory = data[indexPath.row]
        
        NetworkManager.shared.getArticles(category: chosenCategory){ result in
            
            switch result {
            case let .success(articles):
                
                let nextView: ArticlesListViewController = ArticlesListViewController()
                
                nextView.articles = articles
                nextView.category = self.data[indexPath.row]
                
                self.navigationController?.pushViewController(nextView, animated: true)
                
            case let .failure(error):
                print(error)
            }
            print(result)
            
        }
        
    }
    
}
