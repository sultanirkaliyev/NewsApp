//
//  TabBarController.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Coordinator
    var coordinator: TabBarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.orange
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
}
