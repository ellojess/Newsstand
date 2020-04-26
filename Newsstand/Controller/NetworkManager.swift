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
    let baseURL = "https://newsapi.org/v2/"
    let APIKey = secretKey
    
    
    func getArticles(_ completion: @escaping (Result<[Article]>) -> Void) {
        let articlesRequest = makeRequest(for: .articles)
        let task = urlSession.dataTask(with: articlesRequest) { data, response, error in
            // Check for errors.
            if let error = error {
                return completion(Result.failure(error))
            }
            
            // Check to see if there is any data that was retrieved.
            guard let data = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            
            // Attempt to decode the data.
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: data) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            let articles = result.results
            
            // Return the result with the completion handler.
            DispatchQueue.main.async {
                completion(Result.success(articles))
            }
        }
        
        task.resume()
    }
    
    
    
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        // grab the parameters from the endpoint and convert them into a string
        let stringParams = endPoint.paramsToString()
        // get the path of the endpoint
        let path = endPoint.getPath()
        // create the full url from the above variables
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))!
        // build the request
        var request = URLRequest(url: fullURL)
        request.httpMethod = endPoint.getHTTPMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(secretKey: secretKey)
        
        return request
    }
    
    enum EndPoints {
        case articles
        
        // determine which path to provide for the API request
        func getPath() -> String {
            switch self {
            case .articles:
                return "top-headlines"
            }
        }
        
        // get http method in a type-safe way
        func getHTTPMethod() -> String {
            return "GET"
        }
        
        // Same headers we used for Postman
        func getHeaders(secretKey: String) -> [String: String] {
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Bearer \(secretKey)",
                "Host": "newsapi.org"
            ]
        }
        
        // grab the parameters for the appropriate object (article)
        func getParams() -> [String: String] {
            switch self {
            case .articles:
                return [
                    "country": "hk",
                    "category": "entertainment"
//                    "category": "category"
                ]
                
            }
        }
        
        // convert params array into a conencted string
        func paramsToString() -> String {
            let parameterArray = getParams().map { key, value in
                return "\(key)=\(value)"
            }
            
            return parameterArray.joined(separator: "&")
        }
        
    }
    
    enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    
}
