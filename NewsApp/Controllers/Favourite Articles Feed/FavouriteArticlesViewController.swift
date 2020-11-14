//
//  FavouriteArticlesViewController.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SnapKit

class FavouriteArticlesViewController: UIViewController {
    
    //MARK: - Views
    var tableView: UITableView!
    
    //MARK: - Coordinator
    var coordinator: FavouriteArticlesCoordinator?
    
    //MARK: - ViewModel
    var viewModel: FavouriteArticlesViewModel?
    
    //MARK: - UIViewController lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        viewModel.fetchArticles()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        setupTableView()
        registerTableViewCells()
        bindData()
    }
    
    //MARK: - MVVM Data Binding
    
    func bindData() {
        if let viewModel = viewModel {
            
            viewModel.articles.bind { [weak self] _ in
                self?.tableView.reloadData()
            }
        }
    }
}

extension FavouriteArticlesViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
    }
    
    func setupNavigationBar() {
        self.title = "Favourite Articles"
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerTableViewCells() {
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseID)
    }
}

extension FavouriteArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.getNumberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseID, for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getArticleCellViewModel(atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let article = viewModel.getArticle(atIndexPath: indexPath)
        coordinator?.coordinateToArticleDetail(article: article)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let viewModel = viewModel else { return nil }
        
        let deleteFromFavouritesAction = UIContextualAction(style: .normal, title: "Delete from favourites") { (action, view, completionHandler: (Bool) -> Void) in
            viewModel.deleteArticleFromFavourites(atIndexPath: indexPath)
            completionHandler(true)
        }
        
        deleteFromFavouritesAction.backgroundColor = .systemRed        
        return UISwipeActionsConfiguration(actions: [deleteFromFavouritesAction])
    }
}
