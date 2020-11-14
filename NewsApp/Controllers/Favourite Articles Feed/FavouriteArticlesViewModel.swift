//
//  FavouriteArticlesViewModel.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class FavouriteArticlesViewModel: FeedViewModelProtocol {
    
    //MARK: - Data Binding Properties
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?> = Box(nil)
    var articles: Box<[Article]> = Box([Article]())
    
    //MARK: - Properties
    internal var page: Int = 1
}

extension FavouriteArticlesViewModel {
    
    func getArticle(atIndexPath indexPath: IndexPath) -> Article {
        return articles.value[indexPath.row]
    }
    
    func getNumberOfArticles() -> Int {
        return articles.value.count
    }
    
    func getArticleCellViewModel(atIndexPath indexPath: IndexPath) -> ArticleTableViewCellViewModel {
        let article = articles.value[indexPath.row]
        return ArticleTableViewCellViewModel(article: article, indexPath: indexPath)
    }
    
    func deleteArticleFromFavourites(atIndexPath indexPath: IndexPath) {
        let article = articles.value[indexPath.row]
        RealmDatabaseArticleService.shared.deleteArticleFromFavourites(article: article)
        articles.value.remove(at: indexPath.row)
    }
}

//MARK: - Data fetching

extension FavouriteArticlesViewModel {
    
    func fetchArticles() {
        articles.value.removeAll()
        articles.value.append(contentsOf: RealmDatabaseArticleService.shared.fetchLocalArticles())
    }
}
