//
//  ArticleTableViewCellViewModel.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class ArticleTableViewCellViewModel {
    
    var articleImage: String? {
        return article.urlToImage
    }
    
    var articleTitle: String? {
        return article.title
    }
    
    var articlePublishedAt: String? {
        return article.publishedAtAsDateFromString?.timeAgoDisplay()
    }
    
    var article: Article
    var indexPath: IndexPath
    
    init(article: Article, indexPath: IndexPath) {
        self.article = article
        self.indexPath = indexPath
    }
}
