//
//  TabBarCoordinator.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: TabBarController
    
    init(navigationController: UINavigationController, tabBarController: TabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        tabBarController.coordinator = self
        
        let topHeadlinesFeedNavigationController = UINavigationController()
        topHeadlinesFeedNavigationController.tabBarItem = UITabBarItem(title: "Top Headlines", image: UIImage(named: "top_headlines_tab_bar_image"), tag: 0)
        let topHeadlinesFeedCoordinator = TopHeadlinesFeedCoordinator(navigationController: topHeadlinesFeedNavigationController)
        
        let everythingFeedNavigationController = UINavigationController()
        everythingFeedNavigationController.tabBarItem = UITabBarItem(title: "Everything", image: UIImage(named: "everything_tab_bar_image"), tag: 1)
        let everythingFeedCoordinator = EverythingFeedCoordinator(navigationController: everythingFeedNavigationController)
        
        let favouriteArticlesNavigationController = UINavigationController()
        favouriteArticlesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        let favouriteArticlesCoordinator = FavouriteArticlesCoordinator(navigationController: favouriteArticlesNavigationController)
        
        tabBarController.viewControllers = [topHeadlinesFeedNavigationController,
                                            everythingFeedNavigationController,
                                            favouriteArticlesNavigationController]
        tabBarController.tabBar.isTranslucent = false
        
        coordinate(to: topHeadlinesFeedCoordinator)
        coordinate(to: everythingFeedCoordinator)
        coordinate(to: favouriteArticlesCoordinator)
    }
}
