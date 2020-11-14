//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SnapKit

class ArticleDetailViewController: UIViewController {
    
    //MARK: - Views
    var articleImageView: UIImageView!
    var stackView: UIStackView!
    
    //MARK: - Coordinator
    var coordinator: ArticleDetailCoordinator?
    
    //MARK: - ViewModel
    var viewModel: ArticleDetailViewModel?
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()        
        guard let viewModel = viewModel else { return }
        fillArticleData(article: viewModel.getArticle())
    }
}

extension ArticleDetailViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
            make.width.equalToSuperview()
        }
        
        articleImageView = UIImageView()
        containerView.addSubview(articleImageView)
        articleImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        articleImageView.image = UIImage(named: "image_not_found_placeholder")
        articleImageView.contentMode = .scaleAspectFit
        articleImageView.layer.masksToBounds = true
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(articleImageView.snp.bottom).offset(10)
        }
    }
    
    func setupNavigationBar() {
        self.title = "Article Detail"
        
        let webBarButton = UIBarButtonItem(title: "See in Web", style: .plain, target: self, action: #selector(openArticleInWebView))
        webBarButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        self.navigationItem.rightBarButtonItem = webBarButton
    }
    
    @objc func openArticleInWebView() {
        guard let viewModel = viewModel else { return }
        coordinator?.openArticleInWebView(article: viewModel.getArticle())
    }
    
    func fillArticleData(article: Article) {
        
        if let articleAuthor = article.author {
            stackView.addArrangedSubview(ContentBlockView(heading: "Author", content: articleAuthor))
        }
        
        if let articleTitle = article.title {
            stackView.addArrangedSubview(ContentBlockView(heading: "Title", content: articleTitle))
        }
        
        if let articleDescription = article.articleDescription {
            stackView.addArrangedSubview(ContentBlockView(heading: "Description", content: articleDescription))
        }
        
        if let articleURL = article.url {
            stackView.addArrangedSubview(ContentBlockView(heading: "URL", content: articleURL))
        }
        
        if let articleURLToImage = article.urlToImage {
            stackView.addArrangedSubview(ContentBlockView(heading: "URL to image", content: articleURLToImage))
            
            if let url = URL(string: articleURLToImage) {
                articleImageView.setIndicatorStyle(.gray)
                articleImageView.setShowActivityIndicator(true)
                articleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "image_not_found_placeholder"))
            }
        }
        
        if let articlePublishedAt = article.publishedAtAsDateFromString {
            stackView.addArrangedSubview(ContentBlockView(heading: "Published at", content: articlePublishedAt.getFormattedDate(format: "d MMMM yyyy")))
        }
        
        if let articleContent = article.content {
            stackView.addArrangedSubview(ContentBlockView(heading: "Content", content: articleContent))
        }
    }
}
