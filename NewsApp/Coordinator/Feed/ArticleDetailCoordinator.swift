//
//  ArticleDetailCoordinator.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class ArticleDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var article: Article
    
    init(navigationController: UINavigationController, article: Article) {
        self.navigationController = navigationController
        self.article = article
    }
    
    func start() {
        let articleDetailViewController = ArticleDetailViewController()
        articleDetailViewController.coordinator = self
        articleDetailViewController.viewModel = ArticleDetailViewModel(article: article)
        navigationController.pushViewController(articleDetailViewController, animated: true)
    }
    
    func openArticleInWebView(article: Article) {
        let articleDetailWebViewViewController = ArticleDetailWebViewViewController()
        articleDetailWebViewViewController.viewModel = ArticleDetailWebViewViewModel(article: article)
        navigationController.pushViewController(articleDetailWebViewViewController, animated: true)
    }
}
