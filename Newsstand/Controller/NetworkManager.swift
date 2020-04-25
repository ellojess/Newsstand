//
//  NetworkManager.swift
//  Newsstand
//
//  Created by Bo on 4/24/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation
import UIKit


class NetworkManager {
    
    let urlSession = URLSession.shared
    let topArticlesURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(secretKey)"
    let APIKey = secretKey


    func fetchTopArticles() {

          // Configure a .default session
          let defaultSession = URLSession(configuration: .default)

          // Create URL
          let url = URL(string: topArticlesURL)

          // Create Request
          let request = URLRequest(url: url!)

          // Create Data Task
          let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

            print("data is: ", data!)
            print("response is: ", response!)

          })
          dataTask.resume() // Start the data task
      }

}
