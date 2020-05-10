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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = .zero
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = UIColor.white
        searchBar.barTintColor = .black
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        // register header view
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
    }
    
    func setViews(){
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(collectionView)
        collectionView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.heightAnchor, multiplier: 1.0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor).isActive = true
        
        collectionView.contentInset = .zero
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.title = "Newsstand"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    // define height of header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    //add search bar to UICollectionview header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }
    
}



extension CategoriesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spaceBetweenCell :CGFloat = 1.0
        let totalSpace = spaceBetweenCell * 1.0
        
        if indexPath.row == data.count-1 { // change view for last cell if odd number of cells
            
            if data.count % 2  == 1 { // check if last cell is odd
                return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height-totalSpace)/3.8) // all Width and same previous height
            } else {
                return CGSize(width: (collectionView.frame.width-totalSpace)/2.1, height: (collectionView.frame.height-totalSpace)/3)
            }
        } else {
            return CGSize(width: (collectionView.frame.width-totalSpace)/2, height: (collectionView.frame.height-totalSpace)/3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.backgroundView = UIImageView(image: (UIImage(named: "\(images[indexPath.row])")))
        cell.title.text = data[indexPath.row]
        
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

