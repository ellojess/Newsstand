//
//  Articles.swift
//  Newsstand
//
//  Created by Bo on 4/25/20.
//  Copyright © 2020 Jessica Trinh. All rights reserved.
//

import Foundation

public struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String? // Direct URL to article
    let urlToImage: String?
    let content: String?
}

public struct ArticleList: Codable {
    public var articles: [Article]
}

struct Source: Codable {
    public let id: String?
    public let name: String?
}
