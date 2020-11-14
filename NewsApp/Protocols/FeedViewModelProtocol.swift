//
//  FeedViewModelProtocol.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

protocol FeedViewModelProtocol: class {
    
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?>   { get set }
    var articles: Box<[Article]>                                         { get set }
    var page: Int                                                        { get set }
    
    func getArticle(atIndexPath indexPath: IndexPath) -> Article
    func getNumberOfArticles() -> Int
    func getArticleCellViewModel(atIndexPath indexPath: IndexPath) -> ArticleTableViewCellViewModel
}

extension FeedViewModelProtocol {
    func fetchArticles(withPagination: Bool, completion: @escaping (Bool) -> ()) {}
    func fetchArticles() {}
}
