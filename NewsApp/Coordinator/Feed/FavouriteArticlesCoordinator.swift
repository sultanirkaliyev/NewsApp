//
//  FavouriteArticlesCoordinator.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class FavouriteArticlesCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favouriteArticlesViewController = FavouriteArticlesViewController()
        favouriteArticlesViewController.coordinator = self
        favouriteArticlesViewController.viewModel = FavouriteArticlesViewModel()
        navigationController.pushViewController(favouriteArticlesViewController, animated: true)
    }
    
    func coordinateToArticleDetail(article: Article) {
        let articleDetailCoordinator = ArticleDetailCoordinator(navigationController: navigationController, article: article)
        coordinate(to: articleDetailCoordinator)
    }
}
