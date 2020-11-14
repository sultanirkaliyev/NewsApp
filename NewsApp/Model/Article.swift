//
//  Article.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let articleSource: ArticleSource?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    init(article: LocalArticle? = nil) {
        self.articleSource = ArticleSource(articleSource: article?.articleSource)
        self.author = article?.author
        self.title = article?.title
        self.articleDescription = article?.articleDescription
        self.url = article?.url
        self.urlToImage = article?.urlToImage
        self.publishedAt = article?.publishedAt
        self.content = article?.content
    }
    
    enum CodingKeys: String, CodingKey {
        case articleSource = "source"
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    var publishedAtAsDateFromString: Date? {
        if let publishedAt = self.publishedAt {
            return publishedAt.convertStringToDate()
        }
        return Date()
    }
}

// MARK: - Source
struct ArticleSource: Codable {
    let id: String?
    let name: String?
    
    init(articleSource: LocalArticleSource? = nil) {
        self.id = articleSource?.id
        self.name = articleSource?.name
    }
}
