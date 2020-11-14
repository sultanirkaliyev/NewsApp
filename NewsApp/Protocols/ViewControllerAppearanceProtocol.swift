//
//  ViewControllerAppearanceProtocol.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

protocol ViewControllerAppearanceProtocol {
    func setupUI()
    func setupNavigationBar()
}

extension ViewControllerAppearanceProtocol {
    
    func setupDelegates() {}
    func setupKeyboard() {}
    func setupTextFields() {}
    func setupTextViews() {}
    func setupPickerViews() {}
    func setupTableView() {}
    func setupCollectionView() {}
    func registerTableViewCells() {}
    func registerCollectionViewCells() {}
    func addGesturesForUIElements() {}
    func removeGesturesFromUIElements() {}
}
