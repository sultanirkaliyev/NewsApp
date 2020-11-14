//
//  EverythingFeedCoordinator.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class EverythingFeedCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let everythingFeedViewController = NewsFeedViewController()
        everythingFeedViewController.coordinator = self
        everythingFeedViewController.viewModel = NewsFeedViewModel(endPoint: .everything, newsFeedDataService: NewsFeedDataService(), qInTitle: "tesla")
        navigationController.pushViewController(everythingFeedViewController, animated: true)
    }
    
    func coordinateToArticleDetail(article: Article) {
        let articleDetailCoordinator = ArticleDetailCoordinator(navigationController: navigationController, article: article)
        coordinate(to: articleDetailCoordinator)
    }
}
