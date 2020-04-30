//
//  ArticlesListViewController.swift
//  Newsstand
//
//  Created by Bo on 4/24/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation
import UIKit

class ArticlesListViewController: UIViewController{
    
    let tableView = UITableView()
    
//    let articles: [Article] = []
    
    var category: String! = nil
    
    let networkManager = NetworkManager()
    
    var articles: [Article] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
//    let dummyData = [
//        Article(title: "One"),
//        Article(title: "Two"),
//        Article(title: "Three")
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        setUpTableView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "cell")
//        updateArticles()
    }
  
// should fetch articles from API
//    func updateArticles() {
//        networkManager.getArticles(category: category!) { result in
//            switch result {
//            case let .success(articles):
//                self.articles = articles
//            case let .failure(error):
//                print(error)
//            }
//            print(result)
//        }
//    }
    
    func setUpTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.backgroundColor = UIColor(red:1.0, green:1.0, blue:0.95, alpha:1.0)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        cell.backgroundColor = .blue
//        cell.data = self.dummyData[indexPath.row]
        
        // retrieve from actual articles, and not mock data
        let article = articles[indexPath.row]
        
        
        cell.textLabel?.text = articles[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected item in row \(indexPath.row)")
        let nextView: DetailViewController = DetailViewController()
//        nextView.title = self.dummyData[indexPath.row].title
        nextView.title = self.articles[indexPath.row].title
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
}
