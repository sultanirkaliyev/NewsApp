//
//  ArticleDetailWebViewViewController.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailWebViewViewController: UIViewController {
    
    //MARK: - Views
    private var wkWebView = WKWebView()
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    
    //MARK: - ViewModel
    var viewModel: ArticleDetailWebViewViewModel?
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        
        guard let viewModel = viewModel, let articleURL = viewModel.getArticleURL() else { return }
        showArticleInWebView(url: articleURL)
    }
}

extension ArticleDetailWebViewViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }        
        wkWebView.navigationDelegate = self
    }
    
    func setupNavigationBar() {
        self.title = "Article Detail (WebView)"
    }
    
    func showArticleInWebView(url: URL) {
        wkWebView.load(URLRequest(url: url))
    }
}

extension ArticleDetailWebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
