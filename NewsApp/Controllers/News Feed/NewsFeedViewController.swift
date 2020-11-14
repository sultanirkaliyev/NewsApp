//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SnapKit

class NewsFeedViewController: UIViewController {
    
    //MARK: - Views
    var tableView: UITableView!
    var footerView: UIView!
    
    let tableViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(tableViewRefreshControlAction), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func tableViewRefreshControlAction(sender: UIRefreshControl) {
        guard let viewModel = viewModel else { return }
        viewModel.fetchArticles(withPagination: false) { [weak self] (isCompleted) in
            self?.tableViewRefreshControl.endRefreshing()
        }
    }
    
    //MARK: - Coordinator
    var coordinator: Coordinator?
    
    //MARK: - ViewModel
    var viewModel: NewsFeedViewModel?
    
    //MARK: - Properties
    private var isLoadingDataProcessing = false
    private var autoUpdateFeedTimer: Timer!
    private var autoUpdateTimeInterval = TimeInterval(floatLiteral: 5.0)
    private var shouldFeedAutoUpdate: Bool = true {
        didSet {
            shouldFeedAutoUpdate ? startAutoUpdateFeed() : autoUpdateFeedTimer.invalidate()
        }
    }
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        registerTableViewCells()
        bindData()
    }
    
    //MARK: - MVVM Data Binding
    
    func bindData() {
        if let viewModel = viewModel {
            
            viewModel.endPoint.bind { [weak self] in
                guard let value = $0 else { return }
                
                switch value {
                case .topHeadlines:
                    self?.setupNavigationBar(withTitle: "Top Headlines")
                    self?.startAutoUpdateFeed()
                case .everything:
                    self?.setupNavigationBar(withTitle: "Everything")
                    viewModel.fetchArticles(withPagination: false, completion: { _ in})
                    guard let tableView = self?.tableView else { return }
                    tableView.refreshControl = self?.tableViewRefreshControl
                }
            }
            
            viewModel.networkRequestFailureReason.bind { [weak self] in
                guard let value = $0 else { return }
                print("Network request error: \(value.heading) - \(value.description)")
            }
            
            viewModel.articles.bind { [weak self] _ in
                self?.tableView.reloadData()
            }            
        }
    }
}

extension NewsFeedViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40))
        footerView.backgroundColor = .white
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        footerView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    func setupNavigationBar() {}
    func setupNavigationBar(withTitle title: String) {
        self.title = title
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.isHidden = true
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
    
    func startAutoUpdateFeed() {
        
        guard let viewModel = viewModel else { return }
        
        autoUpdateFeedTimer = Timer.scheduledTimer(withTimeInterval: autoUpdateTimeInterval, repeats: true, block: { (timer) in
            guard self.shouldFeedAutoUpdate else { timer.invalidate(); return }
            
            if !self.isLoadingDataProcessing {
                self.isLoadingDataProcessing = true
                
                DispatchQueue.main.async {
                    viewModel.fetchArticles(withPagination: false) { (isCompleted) in
                        self.isLoadingDataProcessing = false
                    }
                }
            }
        })
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        if coordinator is TopHeadlinesFeedCoordinator {
            (coordinator as? TopHeadlinesFeedCoordinator)?.coordinateToArticleDetail(article: article)
        } else {
            (coordinator as? EverythingFeedCoordinator)?.coordinateToArticleDetail(article: article)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let viewModel = viewModel else { return nil }
        
        let addToFavouritesAction = UIContextualAction(style: .normal, title: "Add to favourites") { (action, view, completionHandler: (Bool) -> Void) in
            viewModel.addArticleToFavourites(atIndexPath: indexPath)
            completionHandler(true)
        }
        
        let deleteFromFavouritesAction = UIContextualAction(style: .normal, title: "Delete from favourites") { (action, view, completionHandler: (Bool) -> Void) in
            viewModel.deleteArticleFromFavourites(atIndexPath: indexPath)
            completionHandler(true)
        }
        
        addToFavouritesAction.backgroundColor = .orange
        deleteFromFavouritesAction.backgroundColor = .systemRed
        
        if viewModel.isArticleAlreadySaved(atIndexPath: indexPath) {
            return UISwipeActionsConfiguration(actions: [deleteFromFavouritesAction])
        } else {
            return UISwipeActionsConfiguration(actions: [addToFavouritesAction])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let viewModel = viewModel, viewModel.endPoint.value == TypeOfNewsFeedEndPoint.topHeadlines {
            shouldFeedAutoUpdate = ((tableView.safeAreaInsets.top + scrollView.contentOffset.y) == 0)
        }        
        
        if !shouldFeedAutoUpdate {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoadingDataProcessing {
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        guard let viewModel = viewModel else { return }
        
        if !self.isLoadingDataProcessing {
            self.tableView.tableFooterView?.isHidden = false
            self.isLoadingDataProcessing = true
            DispatchQueue.global().async {
                sleep(1)
                DispatchQueue.main.async {
                    viewModel.fetchArticles(withPagination: true) { (isCompleted) in
                        self.tableView.tableFooterView?.isHidden = true
                        self.isLoadingDataProcessing = false
                    }                    
                }
            }
        }
    }
}
