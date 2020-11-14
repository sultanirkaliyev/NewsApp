//
//  NewsFeedService.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum NewsFeedService {
    case getArticles(endPoint: TypeOfNewsFeedEndPoint, page: Int, category: String?, q: String?, qInTitle: String?)
}

extension NewsFeedService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environment) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getArticles(endPoint: let endPoint, _, _, _, _):
            switch endPoint {
            case .topHeadlines:
                return "/top-headlines"
            case .everything:
                return "/everything"
            }
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getArticles(_, _, _, _, _): return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            
        case .getArticles(_, page: let page, category: let category, q: let q, qInTitle: let qInTitle):
            var parameters = [String: Any]()
            parameters["pageSize"] = 15
            parameters["page"] = page
            parameters["sortBy"] = "publishedAt"
            
            if let category = category {
                parameters["category"] = category
            }
            
            if let q = q {
                parameters["q"] = q
            }
            
            if let qInTitle = qInTitle {
                parameters["qInTitle"] = qInTitle
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var authorizationType: AuthorizationType {
        switch self {
            case .getArticles(_, _, _, _, _): return .bearer
        }
    }
}
