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

public struct ArticleList: Codable{
    public var articles: [Article]
}

