//
//  TopHeadlinesFeedCoordinator.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class TopHeadlinesFeedCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let topHeadlinesFeedViewController = NewsFeedViewController()
        topHeadlinesFeedViewController.coordinator = self
        topHeadlinesFeedViewController.viewModel = NewsFeedViewModel(endPoint: .topHeadlines, newsFeedDataService: NewsFeedDataService(), feedCategory: "sports")
        navigationController.pushViewController(topHeadlinesFeedViewController, animated: true)
    }
    
    func coordinateToArticleDetail(article: Article) {
        let articleDetailCoordinator = ArticleDetailCoordinator(navigationController: navigationController, article: article)
        coordinate(to: articleDetailCoordinator)
    }
}
