//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum APIEnvironment {
    case staging
    case qa
    case production
    
    var baseURL: String {
        
        switch self {
        case .staging:    return "https://newsapi.org/v2"
        case .qa:         return "https://newsapi.org/v2"
        case .production: return "https://newsapi.org/v2"
        }
    }
}

struct NetworkManager {
    static let environment: String = APIEnvironment.production.baseURL
}
