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
    let topArticlesURL = ""
    let APIKey = APIKey
    
    let dummyData = [
        Article(title: "One"),
        Article(title: "Two"),
        Article(title: "Three")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        setUpTableView()
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "cell")
    }
    
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
    
    
    func fetchTopArticles() {

          // Configure a .default session
          let defaultSession = URLSession(configuration: .default)

          // Create URL
          let url = URL(string: "https://<your_target_web_service>")

          // Create Request
          let request = URLRequest(url: url!)

          // Create Data Task
          let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

            // handle Response Here

          })
          dataTask.resume() // Start the data task
      }
    
}


extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleCell
        cell.backgroundColor = .blue
        cell.data = self.dummyData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected item in row \(indexPath.row)")
        let nextView: DetailViewController = DetailViewController()
        nextView.title = self.dummyData[indexPath.row].title
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
}
