//
//  NewsFeedViewModel.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import PromiseKit

class NewsFeedViewModel: FeedViewModelProtocol {
    
    //MARK: - Moya Provider
    fileprivate let newsFeedDataService: NewsFeedDataService
    
    //MARK: - Data Binding Properties
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?> = Box(nil)
    var articles: Box<[Article]> = Box([Article]())
    var endPoint: Box<TypeOfNewsFeedEndPoint?> = Box(nil)
    
    //MARK: - Properties
    internal var page: Int = 1
    private var feedCategory: String?
    private var qInTitle: String?
    
    init(endPoint: TypeOfNewsFeedEndPoint, newsFeedDataService: NewsFeedDataService, feedCategory: String) {
        self.endPoint.value = endPoint
        self.newsFeedDataService = newsFeedDataService
        self.feedCategory = feedCategory
    }
    
    init(endPoint: TypeOfNewsFeedEndPoint, newsFeedDataService: NewsFeedDataService, qInTitle: String) {
        self.endPoint.value = endPoint
        self.newsFeedDataService = newsFeedDataService
        self.qInTitle = qInTitle
    }
}

extension NewsFeedViewModel {
    
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
    
    func addArticleToFavourites(atIndexPath indexPath: IndexPath) {
        let article = articles.value[indexPath.row]
        RealmDatabaseArticleService.shared.addArticleToFavourites(article: article)
    }
    
    func deleteArticleFromFavourites(atIndexPath indexPath: IndexPath) {
        let article = articles.value[indexPath.row]
        RealmDatabaseArticleService.shared.deleteArticleFromFavourites(article: article)
    }
    
    func isArticleAlreadySaved(atIndexPath indexPath: IndexPath) -> Bool {
        return RealmDatabaseArticleService.shared.isArticleAlreadySaved(article: articles.value[indexPath.row])
    }
}

//MARK: - Data fetching

extension NewsFeedViewModel {
    
    func fetchArticles(withPagination: Bool, completion: @escaping (Bool) -> ()) {
        
        guard let endPoint = endPoint.value else { return }
        
        if withPagination {
            page += 1
        } else {
            page = 1
        }
        
        firstly {
            newsFeedDataService.getArticles(endPoint: endPoint, page: page, category: feedCategory, q: nil, qInTitle: qInTitle)
        }.done { (result) in
            switch result {
            case .success(payload: let articles):
                if !articles.isEmpty {
                    if withPagination {
                        self.articles.value.append(contentsOf: articles)
                    } else {
                        self.articles.value.removeAll()
                        self.articles.value.append(contentsOf: articles)
                    }                    
                } else {
                    if withPagination {
                        self.page -= 1
                    }
                }
                completion(true)
            default: break
            }
        }.catch { (error) in
            if withPagination {
                self.page -= 1
            }
            self.networkRequestFailureReason.value = error as? NetworkRequestFailureReason
            completion(false)
        }
    }
}
