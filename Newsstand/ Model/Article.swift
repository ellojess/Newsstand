//
//  Articles.swift
//  Newsstand
//
//  Created by Bo on 4/25/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation

public struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: URL? // Direct URL to article
    let urlToImage: URL? //URL to image for the article
    let content: String?
}

//struct ArticleList: Codable {
//    public var results: [Article]
//}

public struct ArticleList: Codable{
    public var articles: [Article]
}

//extension Article: Decodable {
//
//    enum ArticleKeys: String, CodingKey {
//        case author
//        case title
//        case description
//        case url
//        case urlToImage
//        case content
//    }
//
//    init(from decoder: Decoder) throws {
//        // Decode Article from API call
//        let articlesContainer = try decoder.container(keyedBy: ArticleKeys.self)
//
//        author = try articlesContainer.decode(String.self, forKey: .author)
//        title = try articlesContainer.decode(String.self, forKey: .title)
//        description = try articlesContainer.decode(String.self, forKey: .description)
//        url = try articlesContainer.decode(URL.self, forKey: .url)
//        urlToImage = try articlesContainer.decode(URL.self, forKey: .urlToImage)
//        content = try articlesContainer.decode(String.self, forKey: .content)
//
//    }
//
//}
