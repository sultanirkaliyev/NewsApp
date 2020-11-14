//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class ArticleDetailViewModel {
    
    //MARK: - Properties
    private var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    func getArticle() -> Article {
        return article
    }
}
