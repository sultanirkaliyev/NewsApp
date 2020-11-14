//
//  ServerResponseArticles.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

// MARK: - Welcome
struct ServerResponseArticles: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
