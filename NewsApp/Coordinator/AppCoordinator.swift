//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

enum AppStartFlow {
    case tabbar
}

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController = UINavigationController()
    
    let window: UIWindow
    let initFlow: AppStartFlow
    
    init(window: UIWindow, initFlow: AppStartFlow) {
        self.window = window
        self.initFlow = initFlow
    }
    
    func start() {
        
        switch initFlow {
        case .tabbar:
            let tabBarController = TabBarController()
            window.rootViewController = tabBarController
            let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, tabBarController: tabBarController)
            coordinate(to: tabBarCoordinator)
        }
        
        window.makeKeyAndVisible()
    }
}
