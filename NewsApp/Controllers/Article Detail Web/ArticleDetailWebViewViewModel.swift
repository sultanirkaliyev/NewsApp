//
//  ArticleDetailWebViewViewModel.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class ArticleDetailWebViewViewModel {
    
    //MARK: - Properties
    private var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    func getArticleURL() -> URL? {
        guard let articleURL = article.url, let url = URL(string: articleURL) else { return nil }
        return url
    }
}
