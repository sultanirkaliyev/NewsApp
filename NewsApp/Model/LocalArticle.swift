//
//  LocalArticle.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import RealmSwift

class LocalArticle: Object {
    
    @objc dynamic var articleSource: LocalArticleSource?
    @objc dynamic var author: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var articleDescription: String? = nil
    @objc dynamic var url: String? = nil
    @objc dynamic var urlToImage: String? = nil
    @objc dynamic var publishedAt: String? = nil
    @objc dynamic var content: String? = nil
    
    convenience init(article: Article? = nil) {
        self.init()
        
        self.articleSource = LocalArticleSource(articleSource: article?.articleSource)
        self.author = article?.author
        self.title = article?.title
        self.articleDescription = article?.articleDescription
        self.url = article?.url
        self.urlToImage = article?.urlToImage
        self.publishedAt = article?.publishedAt
        self.content = article?.content
    }
    
    var publishedAtAsDateFromString: Date? {
        if let publishedAt = self.publishedAt {
            return publishedAt.convertStringToDate()
        }
        return nil
    }
}

class LocalArticleSource: Object {
    @objc dynamic var id: String? = nil
    @objc dynamic var name: String? = nil
    
    convenience init(articleSource: ArticleSource? = nil) {
        self.init()
        
        self.id = articleSource?.id
        self.name = articleSource?.name
    }
}
