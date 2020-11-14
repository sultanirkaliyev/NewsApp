//
//  RealmDatabaseArticleService.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabaseArticleService {
    
    //MARK: - Realm
    let realm = try! Realm()    
    static let shared = RealmDatabaseArticleService()
}

extension RealmDatabaseArticleService {
    
    func isArticleAlreadySaved(article: Article) -> Bool {
        
        let predicate = NSPredicate(format: "url = %@", "\(article.url ?? "")")
        let localArticles = realm.objects(LocalArticle.self).filter(predicate).toList(ofType: LocalArticle.self)
        
        return !localArticles.isEmpty
    }
    
    func addArticleToFavourites(article: Article) {
        let localArticle = LocalArticle(article: article)
        
        try! realm.write {
            realm.add(localArticle)
        }
    }
    
    func deleteArticleFromFavourites(article: Article) {
        
        let predicate = NSPredicate(format: "url = %@", "\(article.url ?? "")")
        let localArticle = realm.objects(LocalArticle.self).filter(predicate)
        
        try! realm.write {
            realm.delete(localArticle, cascading: true)
        }
    }
    
    func fetchLocalArticles() -> [Article] {
        
        let localArticles = realm.objects(LocalArticle.self).toList(ofType: LocalArticle.self)
        
        var articles = [Article]()
        for localArticle in localArticles {
            articles.append(Article(article: localArticle))
        }
        
        return articles.sorted(by: { $0.publishedAtAsDateFromString?.compare($1.publishedAtAsDateFromString!) == .orderedDescending } )
    }
}
